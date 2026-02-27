import 'package:ant_manager/l10n/app_localizations.dart';
import 'package:ant_manager/services/breeding_sheet_service.dart';
import 'package:flutter/material.dart';

class BreedingSheetsScreen extends StatelessWidget {
  const BreedingSheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sheets = BreedingSheetService(l10n).getSheets();

    return ListView.builder(
      itemCount: sheets.length,
      itemBuilder: (context, index) {
        final sheet = sheets[index];
        return Card(
          child: ExpansionTile(
            title: Text(sheet.species),
            subtitle: Text('${l10n.difficulty}: ${sheet.difficulty}'),
            children: [
              ListTile(
                title: Text(l10n.temperature),
                subtitle: Text(sheet.temperature),
              ),
              ListTile(
                title: Text(l10n.humidity),
                subtitle: Text(sheet.humidity),
              ),
              ListTile(
                title: Text(l10n.hibernation),
                subtitle: Text(sheet.hibernation),
              ),
              ListTile(
                title: Text(l10n.food),
                subtitle: Text(sheet.food),
              ),
              ListTile(
                title: Text(l10n.description),
                subtitle: Text(sheet.description),
              ),
            ],
          ),
        );
      },
    );
  }
}
