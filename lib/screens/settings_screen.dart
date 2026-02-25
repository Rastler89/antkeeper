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

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: StreamBuilder<GoogleSignInAccount?>(
        stream: driveService.currentUserStream,
        initialData: driveService.currentUser,
        builder: (context, snapshot) {
          final user = snapshot.data;

          return ListView(
            children: [
              _buildAccountSection(context, driveService, user),
              const Divider(),
              _buildSyncSection(context, settings, syncService, user),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context, GoogleDriveService driveService, GoogleSignInAccount? user) {
    return ListTile(
      leading: user != null
          ? GoogleUserCircleAvatar(identity: user)
          : const Icon(Icons.account_circle, size: 40),
      title: Text(user != null ? user.displayName ?? 'User' : 'Not Signed In'),
      subtitle: Text(user != null ? user.email : 'Sign in to sync data'),
      trailing: user != null
          ? OutlinedButton(
              onPressed: () async {
                await driveService.signOut();
                // StreamBuilder will handle rebuild
              },
              child: const Text('Sign Out'),
            )
          : ElevatedButton(
              onPressed: () async {
                await driveService.signIn();
                // StreamBuilder will handle rebuild
              },
              child: const Text('Sign In'),
            ),
    );
  }

  Widget _buildSyncSection(
    BuildContext context,
    SettingsProvider settings,
    SyncService syncService,
    GoogleSignInAccount? user,
  ) {
    final isEnabled = settings.isSyncEnabled && user != null;

    return Column(
      children: [
        SwitchListTile(
          title: const Text('Enable Cloud Backup'),
          subtitle: const Text('Sync data to Google Drive'),
          value: settings.isSyncEnabled,
          onChanged: user == null
              ? null
              : (value) {
                  settings.setSyncEnabled(value);
                },
        ),
        ListTile(
          title: const Text('Sync Interval'),
          trailing: DropdownButton<int>(
            value: settings.syncIntervalMinutes,
            onChanged: !settings.isSyncEnabled // Only enabled if sync is enabled (regardless of user? usually both)
                ? null
                : (value) {
                    if (value != null) {
                      settings.setSyncInterval(value);
                    }
                  },
            items: const [
              DropdownMenuItem(value: 15, child: Text('15 Minutes')),
              DropdownMenuItem(value: 60, child: Text('1 Hour')),
              DropdownMenuItem(value: 360, child: Text('6 Hours')),
              DropdownMenuItem(value: 1440, child: Text('Daily')),
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
              label: const Text('Sync Now'),
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
                          const SnackBar(content: Text('Sync completed')),
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
