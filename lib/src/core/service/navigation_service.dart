import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateTo(String routeName, {String? args}) async {
    await navigatorKey.currentContext?.pushNamed(routeName, extra: args);
  }

  void cleanStack() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  void goBack() {
    if (navigatorKey.currentContext?.canPop() ?? false) {
      return navigatorKey.currentContext?.pop();
    }
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigatorKey;
}
