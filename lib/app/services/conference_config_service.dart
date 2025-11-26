import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_conf_web/app/models/conference_config.dart';

class ConferenceConfigService {
  static final ConferenceConfigService _instance = ConferenceConfigService._internal();
  factory ConferenceConfigService() => _instance;
  ConferenceConfigService._internal();

  ConferenceConfig? _config;
  bool _isLoaded = false;

  /// Load conference configuration from JSON file
  Future<void> loadConfig({int year = 2025}) async {
    try {
      final String configPath = 'assets/config/conference_$year.json';
      debugPrint('Loading conference config from: $configPath');

      final String jsonString = await rootBundle.loadString(configPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _config = ConferenceConfig.fromJson(jsonData);
      _isLoaded = true;

      debugPrint('Conference config loaded successfully for year $year');
    } catch (e, stackTrace) {
      debugPrint('Error loading conference config for year $year: $e');
      debugPrint('Stack trace: $stackTrace');
      _isLoaded = false;
      rethrow;
    }
  }

  /// Get the current loaded configuration
  ConferenceConfig? get config {
    if (!_isLoaded || _config == null) {
      throw StateError(
        'Conference config not loaded. Call loadConfig() first.',
      );
    }
    return _config;
  }

  /// Check if config is loaded
  bool get isLoaded => _isLoaded;

  /// Reset the service (useful for testing or reloading)
  void reset() {
    _config = null;
    _isLoaded = false;
  }
}
