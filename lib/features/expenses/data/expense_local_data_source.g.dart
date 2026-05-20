// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(expenseLocalDataSource)
final expenseLocalDataSourceProvider = ExpenseLocalDataSourceProvider._();

final class ExpenseLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<ExpenseLocalDataSource>,
          ExpenseLocalDataSource,
          FutureOr<ExpenseLocalDataSource>
        >
    with
        $FutureModifier<ExpenseLocalDataSource>,
        $FutureProvider<ExpenseLocalDataSource> {
  ExpenseLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'expenseLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$expenseLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<ExpenseLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ExpenseLocalDataSource> create(Ref ref) {
    return expenseLocalDataSource(ref);
  }
}

String _$expenseLocalDataSourceHash() =>
    r'9407290a067e96e5bdde32ebcb92382798e2b00b';
