import 'package:ant_manager/providers/colony_provider.dart';
import 'package:ant_manager/providers/settings_provider.dart';
import 'package:ant_manager/providers/stock_provider.dart';
import 'package:ant_manager/screens/home_screen.dart';
import 'package:ant_manager/services/google_drive_service.dart';
import 'package:ant_manager/services/sync_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final driveService = GoogleDriveService();
  await driveService.init();

  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

  final syncService = SyncService(driveService, settingsProvider);
  syncService.start();

  runApp(MyApp(
    driveService: driveService,
    settingsProvider: settingsProvider,
    syncService: syncService,
  ));
}

class MyApp extends StatelessWidget {
  final GoogleDriveService driveService;
  final SettingsProvider settingsProvider;
  final SyncService syncService;

  const MyApp({
    super.key,
    required this.driveService,
    required this.settingsProvider,
    required this.syncService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsProvider),
        Provider.value(value: driveService),
        Provider.value(value: syncService),
        ChangeNotifierProvider(create: (_) => ColonyProvider(syncService)),
        ChangeNotifierProvider(create: (_) => StockProvider(syncService)),
      ],
      child: MaterialApp(
        title: 'Ant Manager',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
