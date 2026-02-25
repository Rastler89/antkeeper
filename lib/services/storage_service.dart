import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ant_manager/models/colony.dart';
import 'package:ant_manager/models/stock_item.dart';

class StorageService {
  static const String _coloniesFileName = 'colonies.json';
  static const String _stockFileName = 'stock.json';

  Future<String> _localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath();
    return File('$path/$fileName');
  }

  Future<void> saveColonies(List<Colony> colonies) async {
    final file = await _localFile(_coloniesFileName);
    final jsonList = colonies.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<List<Colony>> loadColonies() async {
    try {
      final file = await _localFile(_coloniesFileName);
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      final jsonList = jsonDecode(contents) as List<dynamic>;
      return jsonList.map((e) => Colony.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error loading colonies: $e');
      return [];
    }
  }

  Future<void> saveStock(List<StockItem> stock) async {
    final file = await _localFile(_stockFileName);
    final jsonList = stock.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  Future<List<StockItem>> loadStock() async {
    try {
      final file = await _localFile(_stockFileName);
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      final jsonList = jsonDecode(contents) as List<dynamic>;
      return jsonList.map((e) => StockItem.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error loading stock: $e');
      return [];
    }
  }
}
