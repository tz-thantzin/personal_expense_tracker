// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Personal Expense Tracker';

  @override
  String get expensesTitle => 'Expenses';

  @override
  String get add => 'Add';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteExpenseTooltip => 'Delete expense';

  @override
  String get editExpenseTooltip => 'Edit expense';

  @override
  String get totalSpent => 'Total spent';

  @override
  String get noExpensesRecordedYet => 'No expenses recorded yet';

  @override
  String expenseCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count expenses recorded',
      one: '1 expense recorded',
    );
    return '$_temp0';
  }

  @override
  String get noExpensesYet => 'No expenses yet';

  @override
  String get emptyExpenseMessage =>
      'Add your first expense to start tracking your spending.';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get addExpenseTitle => 'Add expense';

  @override
  String get editExpenseTitle => 'Edit expense';

  @override
  String get titleLabel => 'Title';

  @override
  String get amountLabel => 'Amount';

  @override
  String get dateLabel => 'Date';

  @override
  String get noteLabel => 'Note';

  @override
  String get noteHint => 'Add a note (optional)';

  @override
  String get enterExpenseTitle => 'Enter an expense title.';

  @override
  String get titleTooShort => 'Title is too short.';

  @override
  String get enterValidAmount => 'Enter a valid amount.';

  @override
  String get amountGreaterThanZero => 'Amount must be greater than zero.';

  @override
  String get saving => 'Saving';

  @override
  String get saveExpense => 'Save expense';

  @override
  String get updateExpense => 'Update expense';

  @override
  String couldNotSaveExpense(Object error) {
    return 'Could not save expense: $error';
  }

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get lightMode => 'Light mode';

  @override
  String get darkModeSubtitle => 'Use a dark theme across the app';

  @override
  String get lightModeSubtitle => 'Use a light theme across the app';

  @override
  String get currency => 'Currency';

  @override
  String get selectCurrency => 'Select currency';

  @override
  String get searchCurrency => 'Search currency';

  @override
  String get noCurrencyFound => 'No currency found';

  @override
  String get tutorialSkip => 'Skip';

  @override
  String get tutorialHomeSummaryTitle => 'Your spending at a glance';

  @override
  String get tutorialHomeSummaryDescription =>
      'See your total spent and how many expenses you\'ve recorded.';

  @override
  String get tutorialHomeAddTitle => 'Add an expense';

  @override
  String get tutorialHomeAddDescription =>
      'Tap the plus button to record a new expense.';

  @override
  String get tutorialSettingsThemeTitle => 'Light or dark';

  @override
  String get tutorialSettingsThemeDescription =>
      'Toggle to switch the app between light and dark mode.';

  @override
  String get tutorialSettingsCurrencyTitle => 'Choose your currency';

  @override
  String get tutorialSettingsCurrencyDescription =>
      'Pick the currency used across your expenses.';

  @override
  String get tutorialFormTitleFieldTitle => 'Name your expense';

  @override
  String get tutorialFormTitleFieldDescription =>
      'Give it a short, descriptive title.';

  @override
  String get tutorialFormAmountFieldTitle => 'Enter the amount';

  @override
  String get tutorialFormAmountFieldDescription =>
      'Numbers only — the currency symbol comes from your settings.';

  @override
  String get tutorialFormSaveButtonTitle => 'Save it';

  @override
  String get tutorialFormSaveButtonDescription =>
      'Tap here to save this expense to your list.';
}
