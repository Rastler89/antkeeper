import 'package:ant_manager/models/colony.dart';
import 'package:ant_manager/models/log.dart';
import 'package:ant_manager/models/population_entry.dart';
import 'package:ant_manager/services/storage_service.dart';
import 'package:ant_manager/services/sync_service.dart';
import 'package:flutter/foundation.dart';

class ColonyProvider with ChangeNotifier {
  List<Colony> _colonies = [];
  final StorageService _storageService = StorageService();
  final SyncService? _syncService;
  bool _isLoading = false;

  List<Colony> get colonies => _colonies;
  bool get isLoading => _isLoading;

  ColonyProvider([this._syncService]) {
    loadColonies();
    _syncService?.onDataChanged.listen((_) {
      loadColonies();
    });
  }

  Future<void> loadColonies() async {
    _isLoading = true;
    notifyListeners();
    _colonies = await _storageService.loadColonies();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addColony(Colony colony) async {
    _colonies.add(colony);
    await _save();
    notifyListeners();
  }

  Future<void> deleteColony(String id) async {
    _colonies.removeWhere((colony) => colony.id == id);
    await _save();
    notifyListeners();
  }

  Future<void> updatePopulation(String colonyId, int newPopulation) async {
    final index = _colonies.indexWhere((c) => c.id == colonyId);
    if (index != -1) {
      final colony = _colonies[index];
      colony.population = newPopulation;
      colony.populationHistory.add(PopulationEntry(
        date: DateTime.now(),
        count: newPopulation,
      ));
      _colonies[index] = colony; // Not strictly necessary as it's a reference, but good for clarity
      await _save();
      notifyListeners();
    }
  }

  Future<void> addLog(String colonyId, String content) async {
    final index = _colonies.indexWhere((c) => c.id == colonyId);
    if (index != -1) {
      final colony = _colonies[index];
      colony.logs.add(Log(
        date: DateTime.now(),
        content: content,
      ));
      await _save();
      notifyListeners();
    }
  }

  Future<void> updateColony(Colony updatedColony) async {
    final index = _colonies.indexWhere((c) => c.id == updatedColony.id);
    if (index != -1) {
      _colonies[index] = updatedColony;
      await _save();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    await _storageService.saveColonies(_colonies);
  }
}
