import 'package:flutter/material.dart';
import '../translation/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}