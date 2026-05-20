import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/expense_repository.dart';
import '../domain/expense.dart';

part 'expense_view_model.g.dart';

@riverpod
class ExpenseViewModel extends _$ExpenseViewModel {
  @override
  Future<List<Expense>> build() async {
    final repository = await ref.watch(expenseRepositoryProvider.future);
    return repository.getExpenses();
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required DateTime date,
    String? note,
  }) async {
    final now = DateTime.now();
    final expense = Expense(
      id: now.microsecondsSinceEpoch.toString(),
      title: title.trim(),
      amount: amount,
      date: _dateOnly(date),
      createdAt: now,
      note: _normalizeNote(note),
    );

    final repository = await ref.read(expenseRepositoryProvider.future);
    await repository.addExpense(expense);
    await _refresh();
  }

  Future<void> updateExpense({
    required Expense expense,
    required String title,
    required double amount,
    required DateTime date,
    String? note,
  }) async {
    final updatedExpense = expense.copyWith(
      title: title.trim(),
      amount: amount,
      date: _dateOnly(date),
      note: _normalizeNote(note),
    );

    final repository = await ref.read(expenseRepositoryProvider.future);
    await repository.updateExpense(updatedExpense);
    await _refresh();
  }

  Future<void> deleteExpense(String id) async {
    final repository = await ref.read(expenseRepositoryProvider.future);
    await repository.deleteExpense(id);
    await _refresh();
  }

  Future<void> _refresh() async {
    ref.invalidateSelf();
    await future;
  }

  static DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static String? _normalizeNote(String? note) {
    final trimmed = note?.trim();
    return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }
}
