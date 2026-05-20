import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_expense_tracker/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows empty expense state', (tester) async {
    SharedPreferences.setMockInitialValues({
      'tutorial_seen_home': true,
    });

    await tester.pumpWidget(const ProviderScope(child: ExpenseTrackerApp()));
    await tester.pumpAndSettle();

    expect(find.text('Expenses'), findsOneWidget);
    expect(find.text('No expenses yet'), findsOneWidget);
  });
}
