import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/onboarding/tutorial_presenter.dart';
import '../../../core/onboarding/tutorial_repository.dart';
import '../../settings/presentation/settings_view_model.dart';
import '../domain/expense.dart';
import 'expense_view_model.dart';

class ExpenseFormScreen extends ConsumerStatefulWidget {
  const ExpenseFormScreen({this.expense, super.key});

  static const routeName = 'expense-add';
  static const editRouteName = 'expense-edit';
  static const _tutorialId = 'expense_form';

  final Expense? expense;

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  static const _titleMinLength = 2;
  static const _titleMaxLength = 50;
  static const _noteMaxLength = 200;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  final _titleFieldKey = GlobalKey();
  final _amountFieldKey = GlobalKey();
  final _saveButtonKey = GlobalKey();
  bool _tutorialScheduled = false;

  DateTime _selectedDate = DateTime.now();
  bool _isSaving = false;

  bool get _isEditing => widget.expense != null;

  @override
  void initState() {
    super.initState();

    final expense = widget.expense;
    if (expense != null) {
      final decimalDigits = ref.read(currentCurrencyProvider).decimalDigits;
      _titleController.text = expense.title;
      _amountController.text = expense.amount.toStringAsFixed(decimalDigits);
      _selectedDate = expense.date;
      _noteController.text = expense.note ?? '';
    }

    if (!_isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShowTutorial());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _maybeShowTutorial() async {
    if (_tutorialScheduled) return;
    _tutorialScheduled = true;

    final tutorialRepo = await ref.read(tutorialRepositoryProvider.future);
    if (!mounted || tutorialRepo.hasSeen(ExpenseFormScreen._tutorialId)) return;

    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;

    presentTutorial(
      context: context,
      steps: [
        TutorialStep(
          targetKey: _titleFieldKey,
          title: context.localization.tutorialFormTitleFieldTitle,
          description: context.localization.tutorialFormTitleFieldDescription,
        ),
        TutorialStep(
          targetKey: _amountFieldKey,
          title: context.localization.tutorialFormAmountFieldTitle,
          description: context.localization.tutorialFormAmountFieldDescription,
        ),
        TutorialStep(
          targetKey: _saveButtonKey,
          title: context.localization.tutorialFormSaveButtonTitle,
          description: context.localization.tutorialFormSaveButtonDescription,
          align: ContentAlign.top,
        ),
      ],
      onComplete: () => tutorialRepo.markSeen(ExpenseFormScreen._tutorialId),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year, now.month, now.day),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    try {
      final notifier = ref.read(expenseViewModelProvider.notifier);
      final amount = double.parse(_amountController.text);
      final expense = widget.expense;

      if (expense == null) {
        await notifier.addExpense(
          title: _titleController.text,
          amount: amount,
          date: _selectedDate,
          note: _noteController.text,
        );
      } else {
        await notifier.updateExpense(
          expense: expense,
          title: _titleController.text,
          amount: amount,
          date: _selectedDate,
          note: _noteController.text,
        );
      }

      if (mounted) {
        context.pop();
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.localization.couldNotSaveExpense(error)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? context.localization.editExpenseTitle
              : context.localization.addExpenseTitle,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              TextFormField(
                key: _titleFieldKey,
                controller: _titleController,
                textInputAction: TextInputAction.next,
                maxLength: _titleMaxLength,
                decoration: InputDecoration(
                  labelText: context.localization.titleLabel,
                  prefixIcon: const Icon(Icons.short_text),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.localization.enterExpenseTitle;
                  }
                  if (value.trim().length < _titleMinLength) {
                    return context.localization.titleTooShort;
                  }
                  return null;
                },
              ),
              SizedBox(height: 14.h),
              TextFormField(
                key: _amountFieldKey,
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: context.localization.amountLabel,
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                validator: (value) {
                  final amount = double.tryParse(value ?? '');
                  if (amount == null) {
                    return context.localization.enterValidAmount;
                  }
                  if (amount <= 0) {
                    return context.localization.amountGreaterThanZero;
                  }
                  return null;
                },
              ),
              SizedBox(height: 14.h),
              Card(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 4.h,
                  ),
                  leading: const Icon(Icons.calendar_month_outlined),
                  title: Text(context.localization.dateLabel),
                  subtitle: Text(dateFormat.format(_selectedDate)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _pickDate,
                ),
              ),
              SizedBox(height: 14.h),
              TextFormField(
                controller: _noteController,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                minLines: 3,
                maxLength: _noteMaxLength,
                decoration: InputDecoration(
                  labelText: context.localization.noteLabel,
                  hintText: context.localization.noteHint,
                  alignLabelWithHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 56.h),
                    child: const Icon(Icons.notes_outlined),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              FilledButton.icon(
                key: _saveButtonKey,
                onPressed: _isSaving ? null : _save,
                icon: _isSaving
                    ? SizedBox.square(
                        dimension: 18.w,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check),
                label: Text(
                  _isSaving
                      ? context.localization.saving
                      : _isEditing
                      ? context.localization.updateExpense
                      : context.localization.saveExpense,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 220.ms).slideY(begin: .04, end: 0),
        ),
      ),
    );
  }
}
