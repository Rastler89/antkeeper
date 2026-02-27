import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ant Manager'**
  String get appTitle;

  /// No description provided for @colonies.
  ///
  /// In en, this message translates to:
  /// **'Colonies'**
  String get colonies;

  /// No description provided for @breedingSheets.
  ///
  /// In en, this message translates to:
  /// **'Breeding Sheets'**
  String get breedingSheets;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @notSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Not Signed In'**
  String get notSignedIn;

  /// No description provided for @signInToSync.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync data'**
  String get signInToSync;

  /// No description provided for @enableCloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Enable Cloud Backup'**
  String get enableCloudBackup;

  /// No description provided for @syncDataToDrive.
  ///
  /// In en, this message translates to:
  /// **'Sync data to Google Drive'**
  String get syncDataToDrive;

  /// No description provided for @syncInterval.
  ///
  /// In en, this message translates to:
  /// **'Sync Interval'**
  String get syncInterval;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @syncCompleted.
  ///
  /// In en, this message translates to:
  /// **'Sync completed'**
  String get syncCompleted;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @minutes15.
  ///
  /// In en, this message translates to:
  /// **'15 Minutes'**
  String get minutes15;

  /// No description provided for @hour1.
  ///
  /// In en, this message translates to:
  /// **'1 Hour'**
  String get hour1;

  /// No description provided for @hours6.
  ///
  /// In en, this message translates to:
  /// **'6 Hours'**
  String get hours6;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @addColony.
  ///
  /// In en, this message translates to:
  /// **'Add New Colony'**
  String get addColony;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @species.
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get species;

  /// No description provided for @initialPopulation.
  ///
  /// In en, this message translates to:
  /// **'Initial Population'**
  String get initialPopulation;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @saveColony.
  ///
  /// In en, this message translates to:
  /// **'Save Colony'**
  String get saveColony;

  /// No description provided for @tapToAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to add photo'**
  String get tapToAddPhoto;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterSpecies.
  ///
  /// In en, this message translates to:
  /// **'Please enter a species'**
  String get pleaseEnterSpecies;

  /// No description provided for @pleaseEnterPopulation.
  ///
  /// In en, this message translates to:
  /// **'Please enter a population'**
  String get pleaseEnterPopulation;

  /// No description provided for @pleaseEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// No description provided for @noColoniesYet.
  ///
  /// In en, this message translates to:
  /// **'No colonies yet. Add one!'**
  String get noColoniesYet;

  /// No description provided for @addStockItem.
  ///
  /// In en, this message translates to:
  /// **'Add Stock Item'**
  String get addStockItem;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit (e.g. g, ml)'**
  String get unit;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed'**
  String get signInFailed;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @hibernation.
  ///
  /// In en, this message translates to:
  /// **'Hibernation'**
  String get hibernation;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @messorBarbarusDesc.
  ///
  /// In en, this message translates to:
  /// **'Granivorous species. Easy to keep. Needs a humidity gradient.'**
  String get messorBarbarusDesc;

  /// No description provided for @messorBarbarusHibernation.
  ///
  /// In en, this message translates to:
  /// **'Yes (Nov-Mar at 10-15°C)'**
  String get messorBarbarusHibernation;

  /// No description provided for @lasiusNigerDesc.
  ///
  /// In en, this message translates to:
  /// **'Common garden ant. Very hardy and fast growing.'**
  String get lasiusNigerDesc;

  /// No description provided for @lasiusNigerHibernation.
  ///
  /// In en, this message translates to:
  /// **'Yes (Oct-Mar at 5-10°C)'**
  String get lasiusNigerHibernation;

  /// No description provided for @camponotusCruentatusDesc.
  ///
  /// In en, this message translates to:
  /// **'Large species. Needs heat. Slow development initially.'**
  String get camponotusCruentatusDesc;

  /// No description provided for @camponotusCruentatusHibernation.
  ///
  /// In en, this message translates to:
  /// **'Yes (Nov-Feb at 10-15°C)'**
  String get camponotusCruentatusHibernation;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// No description provided for @seedsInsects.
  ///
  /// In en, this message translates to:
  /// **'Seeds, insects'**
  String get seedsInsects;

  /// No description provided for @sugarWaterInsects.
  ///
  /// In en, this message translates to:
  /// **'Sugar water, insects'**
  String get sugarWaterInsects;

  /// No description provided for @errorDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Configuration error. Please verify your app\'s SHA-1 fingerprint in the Google Cloud Console.'**
  String get errorDeveloper;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan this QR code to export data:'**
  String get scanQrCode;

  /// No description provided for @largeDataWarning.
  ///
  /// In en, this message translates to:
  /// **'Note: Large data might not fit in a single QR code.'**
  String get largeDataWarning;

  /// No description provided for @exportToFile.
  ///
  /// In en, this message translates to:
  /// **'Export to File'**
  String get exportToFile;

  /// No description provided for @importFromFile.
  ///
  /// In en, this message translates to:
  /// **'Import from File'**
  String get importFromFile;

  /// No description provided for @backupSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Backup exported successfully'**
  String get backupSuccessful;

  /// No description provided for @importSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Data imported successfully. Please restart the app or refresh.'**
  String get importSuccessful;

  /// No description provided for @errorBackup.
  ///
  /// In en, this message translates to:
  /// **'Error during backup'**
  String get errorBackup;

  /// No description provided for @errorImport.
  ///
  /// In en, this message translates to:
  /// **'Error during import'**
  String get errorImport;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
