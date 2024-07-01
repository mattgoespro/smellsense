import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  static List<Locale> supportedLocales = [const Locale("en_US")];
  Locale _locale = const Locale('en', 'US');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) {
      throw Exception('Locale not supported');
    }

    _locale = locale;
    notifyListeners();
  }
}
