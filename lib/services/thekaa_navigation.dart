import 'package:flutter/material.dart';
import '../screens/main_scaffold.dart';

/// Centralized service handling global bottom navigation across the entire THEKAA app.
class ThekaaNavigation {
  ThekaaNavigation._();

  static MainScaffoldState? _rootScaffold;

  /// Registers the active [MainScaffoldState].
  static void registerRootScaffold(MainScaffoldState scaffold) {
    _rootScaffold = scaffold;
  }

  /// Unregisters the [MainScaffoldState] when disposed.
  static void unregisterRootScaffold(MainScaffoldState scaffold) {
    if (_rootScaffold == scaffold) {
      _rootScaffold = null;
    }
  }

  /// Returns the current root scaffold if mounted.
  static MainScaffoldState? get currentScaffold {
    if (_rootScaffold != null && _rootScaffold!.mounted) {
      return _rootScaffold;
    }
    return null;
  }

  /// Global bottom navigation action:
  /// Index 0: Home
  /// Index 1: Explore
  /// Index 2: Dabba
  /// Index 3: Orders
  /// Index 4: Profile
  ///
  /// Can be invoked from ANY screen at any depth.
  /// Seamlessly switches the tab on [MainScaffold] and pops down to the root,
  /// preventing unbounded navigation stacks.
  /// Falls back to launching [MainScaffold] if running in standalone test harnesses.
  static void navigateToTab(
    BuildContext context,
    int index, {
    ValueChanged<int>? onNavTap,
  }) {
    // 1. Notify screen-specific or test callback if provided
    onNavTap?.call(index);

    // 2. If root MainScaffold is active, switch tab and pop child routes to root
    final root = currentScaffold;
    if (root != null) {
      root.switchTab(index);
      final nav = Navigator.of(context, rootNavigator: true);
      nav.popUntil((route) => route.isFirst);
      return;
    }

    // 3. If MainScaffold exists as an ancestor in the widget tree
    final ancestor = context.findAncestorStateOfType<MainScaffoldState>();
    if (ancestor != null) {
      ancestor.switchTab(index);
      final nav = Navigator.of(context, rootNavigator: true);
      nav.popUntil((route) => route.isFirst);
      return;
    }

    // 4. Standalone / test fallback when MainScaffold is not present in root hierarchy
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => MainScaffold(initialIndex: index),
      ),
      (route) => false,
    );
  }
}
