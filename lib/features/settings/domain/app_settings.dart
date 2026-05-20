import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'currency.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(Currency.usd) Currency currency,
  }) = _AppSettings;
}
