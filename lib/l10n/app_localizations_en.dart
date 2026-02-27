// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ant Manager';

  @override
  String get colonies => 'Colonies';

  @override
  String get breedingSheets => 'Breeding Sheets';

  @override
  String get stock => 'Stock';

  @override
  String get settings => 'Settings';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get notSignedIn => 'Not Signed In';

  @override
  String get signInToSync => 'Sign in to sync data';

  @override
  String get enableCloudBackup => 'Enable Cloud Backup';

  @override
  String get syncDataToDrive => 'Sync data to Google Drive';

  @override
  String get syncInterval => 'Sync Interval';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get syncCompleted => 'Sync completed';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get minutes15 => '15 Minutes';

  @override
  String get hour1 => '1 Hour';

  @override
  String get hours6 => '6 Hours';

  @override
  String get daily => 'Daily';

  @override
  String get addColony => 'Add New Colony';

  @override
  String get name => 'Name';

  @override
  String get species => 'Species';

  @override
  String get initialPopulation => 'Initial Population';

  @override
  String get description => 'Description';

  @override
  String get saveColony => 'Save Colony';

  @override
  String get tapToAddPhoto => 'Tap to add photo';

  @override
  String get pleaseEnterName => 'Please enter a name';

  @override
  String get pleaseEnterSpecies => 'Please enter a species';

  @override
  String get pleaseEnterPopulation => 'Please enter a population';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get noColoniesYet => 'No colonies yet. Add one!';

  @override
  String get addStockItem => 'Add Stock Item';

  @override
  String get quantity => 'Quantity';

  @override
  String get unit => 'Unit (e.g. g, ml)';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get signInFailed => 'Sign in failed';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get hibernation => 'Hibernation';

  @override
  String get food => 'Food';

  @override
  String get messorBarbarusDesc =>
      'Granivorous species. Easy to keep. Needs a humidity gradient.';

  @override
  String get messorBarbarusHibernation => 'Yes (Nov-Mar at 10-15°C)';

  @override
  String get lasiusNigerDesc =>
      'Common garden ant. Very hardy and fast growing.';

  @override
  String get lasiusNigerHibernation => 'Yes (Oct-Mar at 5-10°C)';

  @override
  String get camponotusCruentatusDesc =>
      'Large species. Needs heat. Slow development initially.';

  @override
  String get camponotusCruentatusHibernation => 'Yes (Nov-Feb at 10-15°C)';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get seedsInsects => 'Seeds, insects';

  @override
  String get sugarWaterInsects => 'Sugar water, insects';

  @override
  String get errorDeveloper =>
      'Configuration error. Please verify your app\'s SHA-1 fingerprint in the Google Cloud Console.';
}
