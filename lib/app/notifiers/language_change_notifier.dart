import 'package:flutter/widgets.dart';

class LanguageChangeNotifier extends ChangeNotifier {
  Locale _locale;

  LanguageChangeNotifier({
    Locale locale = const Locale('es'),
  }) : _locale = locale;

  Locale get locale => _locale;

  bool get isSpanish => _locale.languageCode == 'es';

  String get languageText => isSpanish ? 'ES' : 'EN';

  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
