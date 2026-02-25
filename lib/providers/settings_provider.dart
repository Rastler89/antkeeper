import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  static const String _keyIsSyncEnabled = 'is_sync_enabled';
  static const String _keySyncInterval = 'sync_interval_minutes';

  bool _isSyncEnabled = false;
  int _syncIntervalMinutes = 60; // Default 1 hour

  bool get isSyncEnabled => _isSyncEnabled;
  int get syncIntervalMinutes => _syncIntervalMinutes;

  SettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isSyncEnabled = prefs.getBool(_keyIsSyncEnabled) ?? false;
    _syncIntervalMinutes = prefs.getInt(_keySyncInterval) ?? 60;
    notifyListeners();
  }

  Future<void> setSyncEnabled(bool enabled) async {
    _isSyncEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsSyncEnabled, enabled);
    notifyListeners();
  }

  Future<void> setSyncInterval(int minutes) async {
    _syncIntervalMinutes = minutes;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySyncInterval, minutes);
    notifyListeners();
  }
}
