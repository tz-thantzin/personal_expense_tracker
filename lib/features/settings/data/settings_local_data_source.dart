import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/shared_preferences_provider.dart';
import '../domain/app_settings.dart';
import '../domain/currency.dart';

part 'settings_local_data_source.g.dart';

class SettingsLocalDataSource {
  SettingsLocalDataSource(this._preferences);

  static const _themeModeKey = 'theme_mode';
  static const _currencyKey = 'currency_code';

  final SharedPreferences _preferences;

  Future<AppSettings> load() async {
    final themeRaw = _preferences.getString(_themeModeKey);
    final currencyCode = _preferences.getString(_currencyKey);

    return AppSettings(
      themeMode: _parseThemeMode(themeRaw),
      currency: currencyCode == null
          ? Currency.usd
          : Currency.fromCode(currencyCode),
    );
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final saved = await _preferences.setString(_themeModeKey, mode.name);
    if (!saved) {
      throw Exception('Unable to save theme mode.');
    }
  }

  Future<void> saveCurrency(Currency currency) async {
    final saved = await _preferences.setString(_currencyKey, currency.code);
    if (!saved) {
      throw Exception('Unable to save currency.');
    }
  }

  ThemeMode _parseThemeMode(String? value) {
    if (value == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}

@riverpod
Future<SettingsLocalDataSource> settingsLocalDataSource(Ref ref) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  return SettingsLocalDataSource(preferences);
}
