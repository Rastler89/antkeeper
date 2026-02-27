// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Gestor de Hormigas';

  @override
  String get colonies => 'Colonias';

  @override
  String get breedingSheets => 'Fichas de Cría';

  @override
  String get stock => 'Inventario';

  @override
  String get settings => 'Ajustes';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get signOut => 'Cerrar Sesión';

  @override
  String get notSignedIn => 'No has iniciado sesión';

  @override
  String get signInToSync => 'Inicia sesión para sincronizar';

  @override
  String get enableCloudBackup => 'Activar Copia en la Nube';

  @override
  String get syncDataToDrive => 'Sincronizar datos con Google Drive';

  @override
  String get syncInterval => 'Intervalo de Sincronización';

  @override
  String get syncNow => 'Sincronizar Ahora';

  @override
  String get syncCompleted => 'Sincronización completada';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get minutes15 => '15 Minutos';

  @override
  String get hour1 => '1 Hora';

  @override
  String get hours6 => '6 Horas';

  @override
  String get daily => 'Diario';

  @override
  String get addColony => 'Añadir Nueva Colonia';

  @override
  String get name => 'Nombre';

  @override
  String get species => 'Especie';

  @override
  String get initialPopulation => 'Población Inicial';

  @override
  String get description => 'Descripción';

  @override
  String get saveColony => 'Guardar Colonia';

  @override
  String get tapToAddPhoto => 'Toca para añadir foto';

  @override
  String get pleaseEnterName => 'Por favor introduce un nombre';

  @override
  String get pleaseEnterSpecies => 'Por favor introduce una especie';

  @override
  String get pleaseEnterPopulation => 'Por favor introduce una población';

  @override
  String get pleaseEnterValidNumber => 'Por favor introduce un número válido';

  @override
  String get noColoniesYet => 'Aún no hay colonias. ¡Añade una!';

  @override
  String get addStockItem => 'Añadir Ítem de Inventario';

  @override
  String get quantity => 'Cantidad';

  @override
  String get unit => 'Unidad (ej. g, ml)';

  @override
  String get cancel => 'Cancelar';

  @override
  String get add => 'Añadir';

  @override
  String get signInFailed => 'Inicio de sesión fallido';

  @override
  String get difficulty => 'Dificultad';

  @override
  String get temperature => 'Temperatura';

  @override
  String get humidity => 'Humedad';

  @override
  String get hibernation => 'Hibernación';

  @override
  String get food => 'Alimentación';

  @override
  String get messorBarbarusDesc =>
      'Especie granívora. Fácil de mantener. Necesita gradiente de humedad.';

  @override
  String get messorBarbarusHibernation => 'Sí (Nov-Mar a 10-15°C)';

  @override
  String get lasiusNigerDesc =>
      'Hormiga común de jardín. Muy resistente y de crecimiento rápido.';

  @override
  String get lasiusNigerHibernation => 'Sí (Oct-Mar a 5-10°C)';

  @override
  String get camponotusCruentatusDesc =>
      'Especie grande. Necesita calor. Desarrollo lento inicialmente.';

  @override
  String get camponotusCruentatusHibernation => 'Sí (Nov-Feb a 10-15°C)';

  @override
  String get easy => 'Fácil';

  @override
  String get medium => 'Medio';

  @override
  String get hard => 'Difícil';

  @override
  String get seedsInsects => 'Semillas, insectos';

  @override
  String get sugarWaterInsects => 'Agua con azúcar, insectos';

  @override
  String get errorDeveloper =>
      'Error de configuración. Verifique la huella digital SHA-1 de su aplicación en la consola de Google Cloud.';

  @override
  String get exportData => 'Exportar Datos';

  @override
  String get scanQrCode => 'Escanea este código QR para exportar datos:';

  @override
  String get largeDataWarning =>
      'Nota: Los datos grandes pueden no caber en un solo código QR.';

  @override
  String get exportToFile => 'Exportar a Archivo';

  @override
  String get importFromFile => 'Importar desde Archivo';

  @override
  String get backupSuccessful => 'Copia de seguridad exportada correctamente';

  @override
  String get importSuccessful =>
      'Datos importados correctamente. Por favor reinicia o actualiza.';

  @override
  String get errorBackup => 'Error durante la copia de seguridad';

  @override
  String get errorImport => 'Error durante la importación';
}
