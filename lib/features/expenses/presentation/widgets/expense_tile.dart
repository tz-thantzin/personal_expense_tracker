import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../../app/app_colors.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../settings/domain/currency.dart';
import '../../domain/expense.dart';

class ExpenseTile extends StatelessWidget {
  ExpenseTile({
    required this.expense,
    required this.currency,
    required this.onEdit,
    required this.onDelete,
    super.key,
  }) : _currencyFormat = NumberFormat.currency(
         symbol: currency.symbol,
         decimalDigits: currency.decimalDigits,
       );

  final Expense expense;
  final Currency currency;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  final NumberFormat _currencyFormat;
  final _dateFormat = DateFormat.yMMMd();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Slidable(
      key: ValueKey(expense.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.48,
        children: [
          _buildAction(
            onPressed: onEdit,
            backgroundColor: AppColors.editAction,
            icon: Icons.edit_outlined,
            label: context.localization.edit,
          ),
          _buildAction(
            onPressed: onDelete,
            backgroundColor: AppColors.deleteAction,
            icon: Icons.delete_outline,
            label: context.localization.delete,
          ),
        ],
      ),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _dateFormat.format(expense.date),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (expense.note != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        expense.note!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                _currencyFormat.format(expense.amount),
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAction({
    required VoidCallback onPressed,
    required Color backgroundColor,
    required IconData icon,
    required String label,
  }) {
    return SlidableAction(
      onPressed: (_) => onPressed(),
      backgroundColor: backgroundColor,
      foregroundColor: AppColors.onAction,
      icon: icon,
      label: label,
      borderRadius: BorderRadius.circular(8.r),
    );
  }
}
