import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/extensions/context_extension.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({required this.shell, super.key});

  final StatefulNavigationShell shell;

  void _onDestinationSelected(int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: context.localization.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: context.localization.settings,
          ),
        ],
      ),
    );
  }
}
