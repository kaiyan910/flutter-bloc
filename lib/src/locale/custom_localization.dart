import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);

class CustomLocalization {

  LocaleChangeCallback onLocaleChanged;
}

final customLocalization = CustomLocalization();