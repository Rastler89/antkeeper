import 'package:ant_manager/l10n/app_localizations.dart';
import 'package:ant_manager/models/breeding_sheet.dart';

class BreedingSheetService {
  final AppLocalizations l10n;

  BreedingSheetService(this.l10n);

  List<BreedingSheet> getSheets() {
    return [
      BreedingSheet(
        species: 'Messor barbarus',
        difficulty: l10n.easy,
        humidity: '50-70%',
        temperature: '22-28°C',
        hibernation: l10n.messorBarbarusHibernation,
        food: l10n.seedsInsects,
        description: l10n.messorBarbarusDesc,
      ),
      BreedingSheet(
        species: 'Lasius niger',
        difficulty: l10n.easy,
        humidity: '50-60%',
        temperature: '20-25°C',
        hibernation: l10n.lasiusNigerHibernation,
        food: l10n.sugarWaterInsects,
        description: l10n.lasiusNigerDesc,
      ),
      BreedingSheet(
        species: 'Camponotus cruentatus',
        difficulty: l10n.medium,
        humidity: '40-60%',
        temperature: '24-30°C',
        hibernation: l10n.camponotusCruentatusHibernation,
        food: l10n.sugarWaterInsects,
        description: l10n.camponotusCruentatusDesc,
      ),
    ];
  }
}
