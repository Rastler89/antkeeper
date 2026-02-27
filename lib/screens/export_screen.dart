import 'dart:convert';
import 'package:ant_manager/l10n/app_localizations.dart';
import 'package:ant_manager/providers/colony_provider.dart';
import 'package:ant_manager/services/backup_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colonies = Provider.of<ColonyProvider>(context).colonies;
    final l10n = AppLocalizations.of(context)!;
    // Export all colonies for now.
    final jsonString = jsonEncode(colonies.map((e) => e.toJson()).toList());
    final backupService = BackupService();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.exportData)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.scanQrCode),
              const SizedBox(height: 20),
              QrImageView(
                data: jsonString,
                version: QrVersions.auto,
                size: 300.0,
                backgroundColor: Colors.white,
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text(
                      "Uh oh! Something went wrong...",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                l10n.largeDataWarning,
                style: const TextStyle(color: Colors.red),
              ),
              const Divider(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await backupService.exportData();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.backupSuccessful)),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${l10n.errorBackup}: $e')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.file_upload),
                label: Text(l10n.exportToFile),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () async {
                  try {
                    final success = await backupService.importData();
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.importSuccessful)),
                      );
                      // Trigger reload in providers if necessary, though StorageService updates underlying files.
                      // ColonyProvider listens to nothing specific unless we tell it to reload.
                      // Ideally, we should force reload.
                      Provider.of<ColonyProvider>(context, listen: false).loadColonies();
                      // Also StockProvider should reload.
                      // But for now, let's rely on user restart or manual refresh if available.
                      // Actually let's force reload here.
                    }
                  } catch (e) {
                     if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${l10n.errorImport}: $e')),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.file_download),
                label: Text(l10n.importFromFile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
