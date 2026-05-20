import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/settings_repository.dart';
import '../domain/app_settings.dart';
import '../domain/currency.dart';

part 'settings_view_model.g.dart';

@Riverpod(keepAlive: true)
class SettingsViewModel extends _$SettingsViewModel {
  @override
  Future<AppSettings> build() async {
    final repository = await ref.watch(settingsRepositoryProvider.future);
    return repository.getSettings();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final repository = await ref.read(settingsRepositoryProvider.future);
    await repository.setThemeMode(mode);
    await _refresh();
  }

  Future<void> setCurrency(Currency currency) async {
    final repository = await ref.read(settingsRepositoryProvider.future);
    await repository.setCurrency(currency);
    await _refresh();
  }

  Future<void> _refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Currency currentCurrency(Ref ref) {
  return ref
      .watch(settingsViewModelProvider)
      .maybeWhen(data: (settings) => settings.currency, orElse: () => Currency.usd);
}

@riverpod
ThemeMode currentThemeMode(Ref ref) {
  return ref
      .watch(settingsViewModelProvider)
      .maybeWhen(
        data: (settings) => settings.themeMode,
        orElse: () => ThemeMode.system,
      );
}
