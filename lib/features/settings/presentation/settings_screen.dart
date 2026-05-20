import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/onboarding/tutorial_presenter.dart';
import '../../../core/onboarding/tutorial_repository.dart';
import 'settings_view_model.dart';
import 'widgets/currency_picker_sheet.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = 'settings';
  static const _tutorialId = 'settings';

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _themeTileKey = GlobalKey();
  final _currencyTileKey = GlobalKey();
  bool _tutorialScheduled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShowTutorial());
  }

  Future<void> _maybeShowTutorial() async {
    if (_tutorialScheduled) return;
    _tutorialScheduled = true;

    final tutorialRepo = await ref.read(tutorialRepositoryProvider.future);
    if (!mounted || tutorialRepo.hasSeen(SettingsScreen._tutorialId)) return;

    await ref.read(settingsViewModelProvider.future);
    if (!mounted) return;
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;

    presentTutorial(
      context: context,
      steps: [
        TutorialStep(
          targetKey: _themeTileKey,
          title: context.localization.tutorialSettingsThemeTitle,
          description: context.localization.tutorialSettingsThemeDescription,
        ),
        TutorialStep(
          targetKey: _currencyTileKey,
          title: context.localization.tutorialSettingsCurrencyTitle,
          description: context.localization.tutorialSettingsCurrencyDescription,
        ),
      ],
      onComplete: () => tutorialRepo.markSeen(SettingsScreen._tutorialId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(settingsViewModelProvider);
    final notifier = ref.read(settingsViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(context.localization.settingsTitle)),
      body: settingsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Text(
              context.localization.somethingWentWrong,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (settings) {
          final isDark = settings.themeMode == ThemeMode.dark;

          return ListView(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            children: [
              SwitchListTile(
                key: _themeTileKey,
                secondary: Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode_outlined,
                ),
                title: Text(
                  isDark
                      ? context.localization.darkMode
                      : context.localization.lightMode,
                ),
                subtitle: Text(
                  isDark
                      ? context.localization.darkModeSubtitle
                      : context.localization.lightModeSubtitle,
                ),
                value: isDark,
                onChanged: (value) {
                  notifier.setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
              const Divider(height: 0),
              ListTile(
                key: _currencyTileKey,
                leading: Text(
                  settings.currency.flag,
                  style: TextStyle(fontSize: 24.sp),
                ),
                title: Text(context.localization.currency),
                subtitle: Text(
                  '${settings.currency.code}  •  ${settings.currency.name}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final picked = await showCurrencyPickerSheet(context);
                  if (picked != null) {
                    await notifier.setCurrency(picked);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
