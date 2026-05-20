import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/onboarding/tutorial_presenter.dart';
import '../../../core/onboarding/tutorial_repository.dart';
import '../../settings/domain/currency.dart';
import '../../settings/presentation/settings_view_model.dart';
import 'expense_form_screen.dart';
import 'expense_view_model.dart';
import 'widgets/expense_tile.dart';

class ExpenseListScreen extends ConsumerStatefulWidget {
  const ExpenseListScreen({super.key});

  static const routeName = 'expense-list';
  static const _tutorialId = 'home';

  @override
  ConsumerState<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends ConsumerState<ExpenseListScreen> {
  final _summaryKey = GlobalKey();
  final _fabKey = GlobalKey();
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
    if (!mounted || tutorialRepo.hasSeen(ExpenseListScreen._tutorialId)) return;

    // Wait for the expense list to finish loading so the summary card exists.
    await ref.read(expenseViewModelProvider.future);
    if (!mounted) return;
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;

    presentTutorial(
      context: context,
      steps: [
        TutorialStep(
          targetKey: _summaryKey,
          title: context.localization.tutorialHomeSummaryTitle,
          description: context.localization.tutorialHomeSummaryDescription,
        ),
        TutorialStep(
          targetKey: _fabKey,
          title: context.localization.tutorialHomeAddTitle,
          description: context.localization.tutorialHomeAddDescription,
          align: ContentAlign.top,
          shape: ShapeLightFocus.Circle,
        ),
      ],
      onComplete: () => tutorialRepo.markSeen(ExpenseListScreen._tutorialId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expensesState = ref.watch(expenseViewModelProvider);
    final currency = ref.watch(currentCurrencyProvider);
    final listPadding = EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 96.h);

    return Scaffold(
      appBar: AppBar(title: Text(context.localization.expensesTitle)),
      body: expensesState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => _ErrorState(
          message: error.toString(),
          onRetry: () => ref.invalidate(expenseViewModelProvider),
        ),
        data: (expenses) {
          final total = expenses.fold<double>(
            0,
            (sum, expense) => sum + expense.amount,
          );

          if (expenses.isEmpty) {
            return ListView(
              padding: listPadding,
              children: [
                _SummaryHeader(
                  key: _summaryKey,
                  total: total,
                  count: expenses.length,
                  currency: currency,
                ),
                SizedBox(height: 80.h),
                const _EmptyState(),
              ],
            );
          }

          return ListView.separated(
            padding: listPadding,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _SummaryHeader(
                  key: _summaryKey,
                  total: total,
                  count: expenses.length,
                  currency: currency,
                );
              }

              final expense = expenses[index - 1];
              return ExpenseTile(
                expense: expense,
                currency: currency,
                onEdit: () {
                  context.pushNamed(
                    ExpenseFormScreen.editRouteName,
                    extra: expense,
                  );
                },
                onDelete: () {
                  ref
                      .read(expenseViewModelProvider.notifier)
                      .deleteExpense(expense.id);
                },
              ).animate().fadeIn(duration: 220.ms);
            },
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemCount: expenses.length + 1,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: _fabKey,
        onPressed: () => context.pushNamed(ExpenseFormScreen.routeName),
        icon: const Icon(Icons.add),
        label: Text(context.localization.add),
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  _SummaryHeader({
    super.key,
    required this.total,
    required this.count,
    required this.currency,
  }) : _currencyFormat = NumberFormat.currency(
         symbol: currency.symbol,
         decimalDigits: currency.decimalDigits,
       );

  final double total;
  final int count;
  final Currency currency;
  final NumberFormat _currencyFormat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localization.totalSpent,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _currencyFormat.format(total),
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              count == 0
                  ? context.localization.noExpensesRecordedYet
                  : context.localization.expenseCount(count),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 250.ms).slideY(begin: .08, end: 0);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child:
            Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 56.w,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      context.localization.noExpensesYet,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.localization.emptyExpenseMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                )
                .animate()
                .fadeIn(duration: 250.ms)
                .scale(begin: const Offset(.98, .98)),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            SizedBox(height: 12.h),
            Text(
              context.localization.somethingWentWrong,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 16.h),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.localization.retry),
            ),
          ],
        ),
      ),
    );
  }
}
