import 'dart:io';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis_auth/googleapis_auth.dart' as auth;

class GoogleDriveService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [drive.DriveApi.driveFileScope],
  );

  GoogleSignInAccount? _currentUser;
  drive.DriveApi? _driveApi;

  GoogleSignInAccount? get currentUser => _currentUser;
  Stream<GoogleSignInAccount?> get currentUserStream => _googleSignIn.onCurrentUserChanged;

  // Initialize and listen for user changes
  Future<void> init() async {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      _currentUser = account;
      if (_currentUser != null) {
        // Create an authenticated client
        try {
          final client = await _googleSignIn.authenticatedClient();
          if (client != null) {
            _driveApi = drive.DriveApi(client);
          }
        } catch (e) {
          if (kDebugMode) {
            print('Error getting authenticated client: $e');
          }
          _driveApi = null;
        }
      } else {
        _driveApi = null;
      }
    });
    // Attempt to sign in silently
    await _googleSignIn.signInSilently();
  }

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      if (kDebugMode) {
        print('Error signing in: $error');
      }
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
  }

  Future<String?> _getFolderId(String folderName) async {
    if (_driveApi == null) return null;
    try {
      final q = "mimeType = 'application/vnd.google-apps.folder' and name = '$folderName' and trashed = false";
      final fileList = await _driveApi!.files.list(q: q);
      if (fileList.files != null && fileList.files!.isNotEmpty) {
        return fileList.files!.first.id;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting folder ID: $e');
      }
    }
    return null;
  }

  Future<String?> createFolder(String folderName) async {
    if (_driveApi == null) return null;
    try {
      final folder = drive.File();
      folder.name = folderName;
      folder.mimeType = 'application/vnd.google-apps.folder';
      final result = await _driveApi!.files.create(folder);
      return result.id;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating folder: $e');
      }
      return null;
    }
  }

  Future<String?> getOrCreateFolder(String folderName) async {
    final existingId = await _getFolderId(folderName);
    if (existingId != null) return existingId;
    return await createFolder(folderName);
  }

  Future<void> uploadFile(File file, String fileName, String folderId) async {
    if (_driveApi == null) return;

    try {
      // Check if file exists in folder to update it, or create new
      final q = "name = '$fileName' and '$folderId' in parents and trashed = false";
      final fileList = await _driveApi!.files.list(q: q);

      final driveFile = drive.File();
      driveFile.name = fileName;

      final media = drive.Media(file.openRead(), file.lengthSync());

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        // Update
        final fileId = fileList.files!.first.id!;
        await _driveApi!.files.update(driveFile, fileId, uploadMedia: media);
      } else {
        // Create
        driveFile.parents = [folderId];
        await _driveApi!.files.create(driveFile, uploadMedia: media);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading file: $e');
      }
    }
  }

  Future<void> downloadFile(String fileName, String folderId, File saveTo) async {
    if (_driveApi == null) return;

    try {
      final q = "name = '$fileName' and '$folderId' in parents and trashed = false";
      final fileList = await _driveApi!.files.list(q: q);

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        final fileId = fileList.files!.first.id!;
        final media = await _driveApi!.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;

        final stream = media.stream;
        final sink = saveTo.openWrite();
        await stream.pipe(sink);
        await sink.close();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error downloading file: $e');
      }
    }
  }

  Future<DateTime?> getRemoteFileModifiedTime(String fileName, String folderId) async {
    if (_driveApi == null) return null;
    try {
      final q = "name = '$fileName' and '$folderId' in parents and trashed = false";
      final fileList = await _driveApi!.files.list(q: q, $fields: 'files(id, modifiedTime)');

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        return fileList.files!.first.modifiedTime;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting file modified time: $e');
      }
    }
    return null;
  }
}
