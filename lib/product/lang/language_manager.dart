import 'package:flutter/material.dart';

class LanguageManager {
  LanguageManager._();
  static LanguageManager? _instance;
  static LanguageManager get instance {
    if (_instance == null) {
      return _instance = LanguageManager._();
    }
    return _instance!;
  }

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  final deLocale = const Locale('de', 'DE');
  final frLocale = const Locale('fr', 'FR');
  final esLocale = const Locale('es', 'ES');
  final itLocale = const Locale('it', 'IT');
  final idLocale = const Locale('id', 'ID');
  List<Locale> get supportedLocales => [
        enLocale,
        trLocale,
        deLocale,
        frLocale,
        esLocale,
        itLocale,
        idLocale,
      ];
}
