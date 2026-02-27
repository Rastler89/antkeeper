import 'dart:async';
import 'dart:io';
import 'package:ant_manager/providers/settings_provider.dart';
import 'package:ant_manager/services/google_drive_service.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class SyncService {
  final GoogleDriveService _driveService;
  final SettingsProvider _settingsProvider;
  final StreamController<void> _dataChangedController = StreamController<void>.broadcast();

  Stream<void> get onDataChanged => _dataChangedController.stream;

  Timer? _timer;
  bool _isSyncing = false;

  SyncService(this._driveService, this._settingsProvider);

  void start() {
    _scheduleTimer();
    _settingsProvider.addListener(_onSettingsChanged);
  }

  void stop() {
    _timer?.cancel();
    _settingsProvider.removeListener(_onSettingsChanged);
  }

  void _onSettingsChanged() {
    _scheduleTimer();
  }

  void _scheduleTimer() {
    _timer?.cancel();
    if (_settingsProvider.isSyncEnabled) {
      final interval = Duration(minutes: _settingsProvider.syncIntervalMinutes);
      _timer = Timer.periodic(interval, (timer) {
        sync();
      });
    }
  }

  Future<void> sync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      if (_driveService.currentUser == null) {
        // If not signed in, try silent sign in first?
        // Usually init handles this.
        if (kDebugMode) {
          print('Sync skipped: User not signed in');
        }
        return;
      }

      final folderId = await _driveService.getOrCreateFolder('AntManagerBackup');
      if (folderId == null) {
         if (kDebugMode) {
          print('Sync skipped: Could not create folder or access denied');
        }
        // If we can't create folder, maybe our auth is stale or permissions missing.
        // We can't easily force re-auth here without UI interaction, but we log it.
        return;
      }

      bool dataDownloaded = false;
      dataDownloaded |= await _syncFile('colonies.json', folderId);
      dataDownloaded |= await _syncFile('stock.json', folderId);

      if (dataDownloaded) {
        _dataChangedController.add(null);
      }

    } catch (e) {
      if (kDebugMode) {
        print('Sync error: $e');
      }
    } finally {
      _isSyncing = false;
    }
  }

  // Returns true if file was downloaded
  Future<bool> _syncFile(String fileName, String folderId) async {
    final directory = await getApplicationDocumentsDirectory();
    final localFile = File('${directory.path}/$fileName');

    final remoteTime = await _driveService.getRemoteFileModifiedTime(fileName, folderId);

    if (!localFile.existsSync()) {
       if (remoteTime != null) {
         if (kDebugMode) print('Downloading $fileName (local missing)');
         await _driveService.downloadFile(fileName, folderId, localFile);
         return true;
       }
       return false;
    }

    final localTime = localFile.lastModifiedSync().toUtc();

    if (remoteTime == null) {
      // Remote doesn't exist, upload
      if (kDebugMode) print('Uploading $fileName (remote missing)');
      await _driveService.uploadFile(localFile, fileName, folderId);
      return false;
    } else {
      // Both exist, compare
      // Add a small buffer (e.g., 2 seconds) to avoid ping-pong due to clock drift or precision loss
      final diff = localTime.difference(remoteTime).inSeconds;

      if (diff > 5) {
        // Local is significantly newer -> upload
        if (kDebugMode) print('Uploading $fileName (local newer by $diff s)');
        await _driveService.uploadFile(localFile, fileName, folderId);
        return false;
      } else if (diff < -5) {
        // Remote is significantly newer -> download
        if (kDebugMode) print('Downloading $fileName (remote newer by ${-diff} s)');
        await _driveService.downloadFile(fileName, folderId, localFile);
        return true;
      } else {
        if (kDebugMode) print('Skipping $fileName (synced)');
        return false;
      }
    }
  }
}
