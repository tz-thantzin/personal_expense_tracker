import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/data/shared_preferences_provider.dart';
import '../domain/expense.dart';

part 'expense_local_data_source.g.dart';

class ExpenseLocalDataSource {
  ExpenseLocalDataSource(this._preferences);

  static const _storageKey = 'expenses';

  final SharedPreferences _preferences;

  Future<List<Expense>> loadExpenses() async {
    final encoded = _preferences.getString(_storageKey);
    if (encoded == null || encoded.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(encoded);
    if (decoded is! List) {
      throw const FormatException('Saved expenses are not valid.');
    }

    return decoded
        .cast<Map<String, Object?>>()
        .map(ExpenseJson.fromJson)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    final encoded = jsonEncode(
      expenses.map((expense) => expense.toJson()).toList(),
    );
    final saved = await _preferences.setString(_storageKey, encoded);
    if (!saved) {
      throw Exception('Unable to save expenses.');
    }
  }
}

@riverpod
Future<ExpenseLocalDataSource> expenseLocalDataSource(Ref ref) async {
  final preferences = await ref.watch(sharedPreferencesProvider.future);
  return ExpenseLocalDataSource(preferences);
}
