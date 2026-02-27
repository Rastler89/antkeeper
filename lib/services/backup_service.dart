import 'dart:convert';
import 'dart:io';
import 'package:ant_manager/models/colony.dart';
import 'package:ant_manager/models/stock_item.dart';
import 'package:ant_manager/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService {
  final StorageService _storageService = StorageService();

  Future<void> exportData() async {
    try {
      final colonies = await _storageService.loadColonies();
      final stock = await _storageService.loadStock();

      final data = {
        'colonies': colonies.map((e) => e.toJson()).toList(),
        'stock': stock.map((e) => e.toJson()).toList(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      final jsonString = jsonEncode(data);

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/ant_manager_backup_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(jsonString);

      await Share.shareXFiles([XFile(file.path)], text: 'Ant Manager Backup');
    } catch (e) {
      if (kDebugMode) {
        print('Error exporting data: $e');
      }
      rethrow;
    }
  }

  Future<bool> importData() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null) {
        String jsonString;

        if (kIsWeb) {
             if (result.files.single.bytes != null) {
                 jsonString = utf8.decode(result.files.single.bytes!);
             } else {
                 // On web, bytes might be null if we don't use specific flags, but FilePicker usually returns bytes for web.
                 // However, sometimes it returns a blob URL in path.
                 // Let's assume standard byte access for now.
                 throw Exception("Cannot read file bytes (web)");
             }
        } else {
             final path = result.files.single.path;
             if (path != null) {
                final file = File(path);
                jsonString = await file.readAsString();
             } else {
                throw Exception("Cannot read file path");
             }
        }

        final Map<String, dynamic> data = jsonDecode(jsonString);

        if (data.containsKey('colonies')) {
          final List<dynamic> coloniesJson = data['colonies'];
          final colonies = coloniesJson.map((e) => Colony.fromJson(e)).toList();
          await _storageService.saveColonies(colonies);
        }

        if (data.containsKey('stock')) {
          final List<dynamic> stockJson = data['stock'];
          final stock = stockJson.map((e) => StockItem.fromJson(e)).toList();
          await _storageService.saveStock(stock);
        }
        return true;
      }
      return false; // Cancelled
    } catch (e) {
      if (kDebugMode) {
        print('Error importing data: $e');
      }
      rethrow;
    }
  }
}
