import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/shared_preferences_provider.dart';

part 'tutorial_repository.g.dart';

class TutorialRepository {
  TutorialRepository(this._preferences);

  static const _keyPrefix = 'tutorial_seen_';

  final SharedPreferences _preferences;

  bool hasSeen(String id) =>
      _preferences.getBool('$_keyPrefix$id') ?? false;

  Future<void> markSeen(String id) async {
    await _preferences.setBool('$_keyPrefix$id', true);
  }
}

@Riverpod(keepAlive: true)
Future<TutorialRepository> tutorialRepository(Ref ref) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  return TutorialRepository(preferences);
}
