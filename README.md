# Personal Expense Tracker

A small Flutter app built for a mobile. The goal is to
demonstrate code structure, technical decisions, and clear thinking — not to
ship every possible feature.

## Features

### Expenses
- Add, edit, and delete expenses (title, amount, date, optional note)
- Expense list with a running total spent summary
- Swipe actions on list items for edit and delete (`flutter_slidable`)
- Form validation (non-empty title, positive numeric amount)
- Character limits enforced in-field with counters — title up to 50, note up
  to 200; note is multiline and optional
- Notes show under the date on each list tile when present
- Local persistence — data survives app restarts (older saved expenses
  without a `note` field still load cleanly)
- Explicit empty, loading, and error UI states

### App-wide
- Bottom navigation between **Home** and **Settings** tabs (Material 3
  `NavigationBar` inside a `StatefulShellRoute`)
- **Dark / light mode** toggle in Settings (persisted via `shared_preferences`,
  label and icon swap with the toggle state)
- **Currency picker** with searchable bottom sheet — 17 currencies, each shown
  with its flag emoji, code, name, and symbol. Selected currency is persisted
  and used everywhere amounts are displayed (correct symbol and decimal
  digits per currency)
- **First-time coach-mark tutorials** on Home, Settings, and the add-expense
  form (`tutorial_coach_mark`). Each tutorial's "seen" state is stored in
  `shared_preferences` so it only fires once
- Localized strings via ARB / `flutter_localizations`
- Light entrance animations (`flutter_animate`)
- Responsive sizing (`flutter_screenutil`)

### Supported currencies
USD, EUR, GBP, JPY, CNY, KRW, SGD, HKD, TWD, INR, IDR, MYR, THB, VND, PHP,
MMK, AUD. (Zero-decimal currencies — JPY, KRW, IDR, VND, MMK — are formatted
without a decimal portion.)

## Tech Stack

- **Framework:** Flutter (Dart `^3.11.5`)
- **State management:** Riverpod with code generation
  (`flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`)
- **Models:** `freezed` immutable data classes (hand-written JSON extension on
  `Expense`)
- **Navigation:** `go_router` with `StatefulShellRoute.indexedStack`
- **Persistence:** `shared_preferences` (JSON-encoded expenses + scalar
  settings keys)
- **Localization:** `flutter_localizations` + ARB
- **Onboarding:** `tutorial_coach_mark` for first-time coach marks
- **UI helpers:** `flutter_screenutil`, `flutter_animate`, `flutter_slidable`,
  `intl`

## Architecture

Feature-first folders with a thin MVVM layering via Riverpod:

```
lib/
  main.dart                              # runApp + ProviderScope
  app/
    app.dart                             # MaterialApp.router + ScreenUtilInit
                                         # (watches themeMode)
    main_scaffold.dart                   # bottom-nav shell
    router.dart                          # go_router + StatefulShellRoute
    theme.dart                           # light + dark Material 3 themes
    app_colors.dart
  core/
    data/
      shared_preferences_provider.dart   # shared SharedPreferences provider
    extensions/
      context_extension.dart
    onboarding/
      tutorial_repository.dart           # hasSeen / markSeen
      tutorial_presenter.dart            # presentTutorial(...) helper
  features/
    expenses/
      data/                              # repository + local data source
      domain/                            # Freezed Expense model
      presentation/                      # list + form screens, view model
    settings/
      data/                              # settings repository + data source
      domain/                            # AppSettings (Freezed) + Currency
      presentation/                      # settings screen, view model
        widgets/
          currency_picker_sheet.dart     # searchable currency picker
  l10n/                                  # generated AppLocalizations + ARB
```

Data flow within a feature:
`presentation → Repository → LocalDataSource → SharedPreferences`. Domain has
no Flutter dependencies; presentation never touches the data source directly.

`sharedPreferencesProvider` lives in `core/` so both features depend on the
same Riverpod-cached instance.

## Run

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Use `build_runner watch` while iterating on `@freezed` / `@riverpod` files.
ARB regeneration is triggered automatically by `flutter pub get` /
`flutter run` (the project uses `l10n.yaml`).

## Testing APK

For manual testing, use:

```text
assets/apk/personal_expense_tracker.apk
```

## Verify

```sh
flutter analyze
```
