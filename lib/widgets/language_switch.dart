import 'package:flutter/material.dart';
import 'package:flutter_conf_web/notifiers/language_change_notifier.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({
    super.key,
    required this.localeLanguageChangeNotifier,
  });

  final LanguageChangeNotifier localeLanguageChangeNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          localeLanguageChangeNotifier.languageText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        Switch(
          value: localeLanguageChangeNotifier.isSpanish,
          onChanged: (value) {
            localeLanguageChangeNotifier.changeLocale(
              value ? const Locale('es') : const Locale('en'),
            );
          },
        ),
      ],
    );
  }
}
