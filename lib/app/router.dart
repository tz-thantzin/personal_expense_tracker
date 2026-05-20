import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/expenses/domain/expense.dart';
import '../features/expenses/presentation/expense_form_screen.dart';
import '../features/expenses/presentation/expense_list_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import 'main_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/expense/add',
      name: ExpenseFormScreen.routeName,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ExpenseFormScreen(),
    ),
    GoRoute(
      path: '/expense/edit',
      name: ExpenseFormScreen.editRouteName,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final extra = state.extra;
        return ExpenseFormScreen(
          expense: extra is Expense ? extra : null,
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainScaffold(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: ExpenseListScreen.routeName,
              builder: (context, state) => const ExpenseListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: SettingsScreen.routeName,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
