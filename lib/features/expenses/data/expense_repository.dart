import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/expense.dart';
import 'expense_local_data_source.dart';

part 'expense_repository.g.dart';

class ExpenseRepository {
  ExpenseRepository(this._localDataSource);

  final ExpenseLocalDataSource _localDataSource;

  Future<List<Expense>> getExpenses() {
    return _localDataSource.loadExpenses();
  }

  Future<void> addExpense(Expense expense) async {
    final expenses = await getExpenses();
    await _localDataSource.saveExpenses([expense, ...expenses]);
  }

  Future<void> updateExpense(Expense updatedExpense) async {
    final expenses = await getExpenses();
    await _localDataSource.saveExpenses(
      expenses
          .map(
            (expense) =>
                expense.id == updatedExpense.id ? updatedExpense : expense,
          )
          .toList(),
    );
  }

  Future<void> deleteExpense(String id) async {
    final expenses = await getExpenses();
    await _localDataSource.saveExpenses(
      expenses.where((expense) => expense.id != id).toList(),
    );
  }
}

@riverpod
Future<ExpenseRepository> expenseRepository(Ref ref) async {
  final localDataSource = await ref.watch(
    expenseLocalDataSourceProvider.future,
  );
  return ExpenseRepository(localDataSource);
}
