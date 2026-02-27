import 'package:ant_manager/l10n/app_localizations.dart';
import 'package:ant_manager/providers/settings_provider.dart';
import 'package:ant_manager/services/google_drive_service.dart';
import 'package:ant_manager/services/sync_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isSyncingNow = false;

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    final driveService = Provider.of<GoogleDriveService>(context, listen: false);
    final syncService = Provider.of<SyncService>(context, listen: false);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: StreamBuilder<GoogleSignInAccount?>(
        stream: driveService.currentUserStream,
        initialData: driveService.currentUser,
        builder: (context, snapshot) {
          final user = snapshot.data;

          return ListView(
            children: [
              _buildLanguageSection(context, settings, l10n),
              const Divider(),
              _buildAccountSection(context, driveService, user, l10n),
              const Divider(),
              _buildSyncSection(context, settings, syncService, user, l10n),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, SettingsProvider settings, AppLocalizations l10n) {
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(l10n.language),
      trailing: DropdownButton<String>(
        value: settings.locale.languageCode,
        onChanged: (String? newValue) {
          if (newValue != null) {
            settings.setLocale(Locale(newValue));
          }
        },
        items: const [
          DropdownMenuItem(value: 'en', child: Text('English')),
          DropdownMenuItem(value: 'es', child: Text('Español')),
        ],
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context, GoogleDriveService driveService, GoogleSignInAccount? user, AppLocalizations l10n) {
    return ListTile(
      leading: user != null
          ? GoogleUserCircleAvatar(identity: user)
          : const Icon(Icons.account_circle, size: 40),
      title: Text(user != null ? user.displayName ?? 'User' : l10n.notSignedIn),
      subtitle: Text(user != null ? user.email : l10n.signInToSync),
      trailing: user != null
          ? OutlinedButton(
              onPressed: () async {
                await driveService.signOut();
                // StreamBuilder will handle rebuild
              },
              child: Text(l10n.signOut),
            )
          : ElevatedButton(
              onPressed: () async {
                await driveService.signIn();
                // StreamBuilder will handle rebuild
              },
              child: Text(l10n.signIn),
            ),
    );
  }

  Widget _buildSyncSection(
    BuildContext context,
    SettingsProvider settings,
    SyncService syncService,
    GoogleSignInAccount? user,
    AppLocalizations l10n,
  ) {
    final isEnabled = settings.isSyncEnabled && user != null;

    return Column(
      children: [
        SwitchListTile(
          title: Text(l10n.enableCloudBackup),
          subtitle: Text(l10n.syncDataToDrive),
          value: settings.isSyncEnabled,
          onChanged: user == null
              ? null
              : (value) {
                  settings.setSyncEnabled(value);
                },
        ),
        ListTile(
          title: Text(l10n.syncInterval),
          trailing: DropdownButton<int>(
            value: settings.syncIntervalMinutes,
            onChanged: !settings.isSyncEnabled // Only enabled if sync is enabled (regardless of user? usually both)
                ? null
                : (value) {
                    if (value != null) {
                      settings.setSyncInterval(value);
                    }
                  },
            items: [
              DropdownMenuItem(value: 15, child: Text(l10n.minutes15)),
              DropdownMenuItem(value: 60, child: Text(l10n.hour1)),
              DropdownMenuItem(value: 360, child: Text(l10n.hours6)),
              DropdownMenuItem(value: 1440, child: Text(l10n.daily)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: _isSyncingNow
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.sync),
              label: Text(l10n.syncNow),
              onPressed: (!isEnabled || _isSyncingNow)
                  ? null
                  : () async {
                      setState(() {
                        _isSyncingNow = true;
                      });
                      await syncService.sync();
                      if (mounted) {
                        setState(() {
                          _isSyncingNow = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.syncCompleted)),
                        );
                      }
                    },
            ),
          ),
        ),
      ],
    );
  }
}
