// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tutorialRepository)
final tutorialRepositoryProvider = TutorialRepositoryProvider._();

final class TutorialRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<TutorialRepository>,
          TutorialRepository,
          FutureOr<TutorialRepository>
        >
    with
        $FutureModifier<TutorialRepository>,
        $FutureProvider<TutorialRepository> {
  TutorialRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tutorialRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tutorialRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<TutorialRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TutorialRepository> create(Ref ref) {
    return tutorialRepository(ref);
  }
}

String _$tutorialRepositoryHash() =>
    r'8e2e009fec5b14ef9a8c3d10644ef3dbc0d1d542';
