import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Expense Tracker'**
  String get appTitle;

  /// No description provided for @expensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesTitle;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteExpenseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete expense'**
  String get deleteExpenseTooltip;

  /// No description provided for @editExpenseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit expense'**
  String get editExpenseTooltip;

  /// No description provided for @totalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total spent'**
  String get totalSpent;

  /// No description provided for @noExpensesRecordedYet.
  ///
  /// In en, this message translates to:
  /// **'No expenses recorded yet'**
  String get noExpensesRecordedYet;

  /// No description provided for @expenseCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 expense recorded} other{{count} expenses recorded}}'**
  String expenseCount(int count);

  /// No description provided for @noExpensesYet.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet'**
  String get noExpensesYet;

  /// No description provided for @emptyExpenseMessage.
  ///
  /// In en, this message translates to:
  /// **'Add your first expense to start tracking your spending.'**
  String get emptyExpenseMessage;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @addExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Add expense'**
  String get addExpenseTitle;

  /// No description provided for @editExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit expense'**
  String get editExpenseTitle;

  /// No description provided for @titleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleLabel;

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateLabel;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteLabel;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note (optional)'**
  String get noteHint;

  /// No description provided for @enterExpenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter an expense title.'**
  String get enterExpenseTitle;

  /// No description provided for @titleTooShort.
  ///
  /// In en, this message translates to:
  /// **'Title is too short.'**
  String get titleTooShort;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount.'**
  String get enterValidAmount;

  /// No description provided for @amountGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than zero.'**
  String get amountGreaterThanZero;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// No description provided for @saveExpense.
  ///
  /// In en, this message translates to:
  /// **'Save expense'**
  String get saveExpense;

  /// No description provided for @updateExpense.
  ///
  /// In en, this message translates to:
  /// **'Update expense'**
  String get updateExpense;

  /// No description provided for @couldNotSaveExpense.
  ///
  /// In en, this message translates to:
  /// **'Could not save expense: {error}'**
  String couldNotSaveExpense(Object error);

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use a dark theme across the app'**
  String get darkModeSubtitle;

  /// No description provided for @lightModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use a light theme across the app'**
  String get lightModeSubtitle;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select currency'**
  String get selectCurrency;

  /// No description provided for @searchCurrency.
  ///
  /// In en, this message translates to:
  /// **'Search currency'**
  String get searchCurrency;

  /// No description provided for @noCurrencyFound.
  ///
  /// In en, this message translates to:
  /// **'No currency found'**
  String get noCurrencyFound;

  /// No description provided for @tutorialSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tutorialSkip;

  /// No description provided for @tutorialHomeSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your spending at a glance'**
  String get tutorialHomeSummaryTitle;

  /// No description provided for @tutorialHomeSummaryDescription.
  ///
  /// In en, this message translates to:
  /// **'See your total spent and how many expenses you\'ve recorded.'**
  String get tutorialHomeSummaryDescription;

  /// No description provided for @tutorialHomeAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add an expense'**
  String get tutorialHomeAddTitle;

  /// No description provided for @tutorialHomeAddDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap the plus button to record a new expense.'**
  String get tutorialHomeAddDescription;

  /// No description provided for @tutorialSettingsThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Light or dark'**
  String get tutorialSettingsThemeTitle;

  /// No description provided for @tutorialSettingsThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Toggle to switch the app between light and dark mode.'**
  String get tutorialSettingsThemeDescription;

  /// No description provided for @tutorialSettingsCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your currency'**
  String get tutorialSettingsCurrencyTitle;

  /// No description provided for @tutorialSettingsCurrencyDescription.
  ///
  /// In en, this message translates to:
  /// **'Pick the currency used across your expenses.'**
  String get tutorialSettingsCurrencyDescription;

  /// No description provided for @tutorialFormTitleFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Name your expense'**
  String get tutorialFormTitleFieldTitle;

  /// No description provided for @tutorialFormTitleFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Give it a short, descriptive title.'**
  String get tutorialFormTitleFieldDescription;

  /// No description provided for @tutorialFormAmountFieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount'**
  String get tutorialFormAmountFieldTitle;

  /// No description provided for @tutorialFormAmountFieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Numbers only — the currency symbol comes from your settings.'**
  String get tutorialFormAmountFieldDescription;

  /// No description provided for @tutorialFormSaveButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Save it'**
  String get tutorialFormSaveButtonTitle;

  /// No description provided for @tutorialFormSaveButtonDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap here to save this expense to your list.'**
  String get tutorialFormSaveButtonDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
