import 'dart:convert';
import 'package:ant_manager/providers/colony_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colonies = Provider.of<ColonyProvider>(context).colonies;
    // Export all colonies for now.
    final jsonString = jsonEncode(colonies.map((e) => e.toJson()).toList());

    return Scaffold(
      appBar: AppBar(title: const Text('Export Data')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Scan this QR code to export data:'),
              const SizedBox(height: 20),
              QrImageView(
                data: jsonString,
                version: QrVersions.auto,
                size: 300.0,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                'Note: Large data might not fit in a single QR code.',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
