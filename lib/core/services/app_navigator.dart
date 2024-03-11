import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static Widget? _currentWidget;

  static Future<T?> push<T extends Object?, TO extends Object?>(
      BuildContext context, Widget widget) {
    if (_currentWidget == widget) return Future.value(null);

    _currentWidget = widget;

    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      BuildContext context, Widget widget) {
    if (_currentWidget == widget) return Future.value(null);

    _currentWidget = widget;

    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static Future<T?> pushAndRemoveAll<T extends Object?, TO extends Object?>(
      BuildContext context, Widget widget) {
    if (_currentWidget == widget) return Future.value(null);

    _currentWidget = widget;

    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (_) => false,
    );
  }

  static Future<bool> maybePop<T extends Object?>(BuildContext context,
      [T? result]) {
    _currentWidget = null;

    return Navigator.maybePop(context, result);
  }

  static bool canPop(BuildContext context) {
    return Navigator.canPop(context);
  }
}
