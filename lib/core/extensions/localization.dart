import 'package:flutter/material.dart';
import 'package:trip_marche/core/translation/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}