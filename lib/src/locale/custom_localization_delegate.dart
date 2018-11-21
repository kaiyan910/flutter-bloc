import 'package:flutter/material.dart';
import 'package:news/generated/i18n.dart';

class CustomLocalizationDelegate extends LocalizationsDelegate<S> {

  final Locale overriddenLocale;

  const CustomLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<S> load(Locale locale) => S.delegate.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<S> old) => true;
}