import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/app_settings.dart';
import '../domain/currency.dart';
import 'settings_local_data_source.dart';

part 'settings_repository.g.dart';

class SettingsRepository {
  SettingsRepository(this._localDataSource);

  final SettingsLocalDataSource _localDataSource;

  Future<AppSettings> getSettings() => _localDataSource.load();

  Future<void> setThemeMode(ThemeMode mode) =>
      _localDataSource.saveThemeMode(mode);

  Future<void> setCurrency(Currency currency) =>
      _localDataSource.saveCurrency(currency);
}

@riverpod
Future<SettingsRepository> settingsRepository(Ref ref) async {
  final localDataSource = await ref.watch(
    settingsLocalDataSourceProvider.future,
  );
  return SettingsRepository(localDataSource);
}
