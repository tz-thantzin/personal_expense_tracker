import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../domain/currency.dart';

Future<Currency?> showCurrencyPickerSheet(BuildContext context) {
  return showModalBottomSheet<Currency>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _CurrencyPickerSheet(),
  );
}

class _CurrencyPickerSheet extends StatefulWidget {
  const _CurrencyPickerSheet();

  @override
  State<_CurrencyPickerSheet> createState() => _CurrencyPickerSheetState();
}

class _CurrencyPickerSheetState extends State<_CurrencyPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Currency> get _filtered {
    if (_query.isEmpty) {
      return Currency.supported;
    }
    final q = _query.toLowerCase();
    return Currency.supported.where((currency) {
      return currency.code.toLowerCase().contains(q) ||
          currency.name.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  context.localization.selectCurrency,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              TextField(
                controller: _searchController,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: context.localization.searchCurrency,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: results.isEmpty
                    ? Center(
                        child: Text(context.localization.noCurrencyFound),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final currency = results[index];
                          return ListTile(
                            leading: Text(
                              currency.flag,
                              style: TextStyle(fontSize: 28.sp),
                            ),
                            title: Text('${currency.code}  •  ${currency.name}'),
                            trailing: Text(
                              currency.symbol,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () => Navigator.of(context).pop(currency),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
