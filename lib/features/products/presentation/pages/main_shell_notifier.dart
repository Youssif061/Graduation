import 'package:flutter/material.dart';

/// InheritedWidget that allows any descendant widget to switch tabs
/// inside MainShell without pushing a new route.
class MainShellNotifier extends InheritedWidget {
  final void Function(int index) switchTab;

  const MainShellNotifier({
    super.key,
    required this.switchTab,
    required super.child,
  });

  /// Returns the nearest MainShellNotifier, or null if not inside MainShell.
  static MainShellNotifier? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainShellNotifier>();
  }

  @override
  bool updateShouldNotify(MainShellNotifier oldWidget) => false;
}
