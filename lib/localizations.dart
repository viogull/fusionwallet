import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';


class AppLocalizations {

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });

  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }


  // Return localized string

  appName() => Intl.message(
      'Fusion',
      name: 'appName'
  );


}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

