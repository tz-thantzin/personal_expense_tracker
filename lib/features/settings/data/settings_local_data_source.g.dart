// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsLocalDataSource)
final settingsLocalDataSourceProvider = SettingsLocalDataSourceProvider._();

final class SettingsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<SettingsLocalDataSource>,
          SettingsLocalDataSource,
          FutureOr<SettingsLocalDataSource>
        >
    with
        $FutureModifier<SettingsLocalDataSource>,
        $FutureProvider<SettingsLocalDataSource> {
  SettingsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<SettingsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SettingsLocalDataSource> create(Ref ref) {
    return settingsLocalDataSource(ref);
  }
}

String _$settingsLocalDataSourceHash() =>
    r'0a7382337393f4a4e6d6ad080f886145723ab343';
