import 'package:ant_manager/models/stock_item.dart';
import 'package:ant_manager/services/storage_service.dart';
import 'package:ant_manager/services/sync_service.dart';
import 'package:flutter/foundation.dart';

class StockProvider with ChangeNotifier {
  List<StockItem> _stock = [];
  final StorageService _storageService = StorageService();
  final SyncService? _syncService;
  bool _isLoading = false;

  List<StockItem> get stock => _stock;
  bool get isLoading => _isLoading;

  StockProvider([this._syncService]) {
    loadStock();
    _syncService?.onDataChanged.listen((_) {
      loadStock();
    });
  }

  Future<void> loadStock() async {
    _isLoading = true;
    notifyListeners();
    _stock = await _storageService.loadStock();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addStockItem(StockItem item) async {
    _stock.add(item);
    await _save();
    notifyListeners();
  }

  Future<void> deleteStockItem(String id) async {
    _stock.removeWhere((item) => item.id == id);
    await _save();
    notifyListeners();
  }

  Future<void> updateStockItem(String id, int quantity) async {
    final index = _stock.indexWhere((item) => item.id == id);
    if (index != -1) {
      _stock[index].quantity = quantity;
      await _save();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    await _storageService.saveStock(_stock);
  }
}
