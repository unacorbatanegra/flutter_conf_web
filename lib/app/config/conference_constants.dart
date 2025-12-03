/// Conference configuration constants
class ConferenceConstants {
  /// Current active conference year
  static const int currentYear = 2026;

  /// Configuration file path pattern
  static String getConfigPath(int year) => 'assets/config/conference_$year.json';

  /// Default fallback values
  static const String defaultLocation = 'Asunción, Paraguay';
  static const String defaultVenue = 'Campus UCOM';
  static const String defaultDescription =
      'FlutterConf Paraguay - Conferencia de tecnología Flutter';
}
