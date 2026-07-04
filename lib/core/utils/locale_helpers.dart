import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class KurdishSafeMaterialDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const KurdishSafeMaterialDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    if (locale.languageCode == 'ku') {
      return GlobalMaterialLocalizations.delegate.load(const Locale('en'));
    }
    return GlobalMaterialLocalizations.delegate.load(locale);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<MaterialLocalizations> old) =>
      false;
}

class KurdishSafeCupertinoDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const KurdishSafeCupertinoDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    if (locale.languageCode == 'ku') {
      return GlobalCupertinoLocalizations.delegate.load(const Locale('en'));
    }
    return GlobalCupertinoLocalizations.delegate.load(locale);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<CupertinoLocalizations> old) =>
      false;
}

class KurdishRtlWidgetsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const KurdishRtlWidgetsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    if (locale.languageCode == 'ku') {
      return GlobalWidgetsLocalizations.delegate.load(const Locale('ar'));
    }
    return GlobalWidgetsLocalizations.delegate.load(locale);
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<WidgetsLocalizations> old) =>
      false;
}
