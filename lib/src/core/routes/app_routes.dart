import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/model/employee_model.dart';
import '../../presentation/screens/employee_details/add_employee_detail_screen.dart';
import '../../presentation/screens/employee_details/edit_employee_detail_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../di/di.dart';
import '../service/navigation_service.dart';

mixin AppRoutes {
  static Widget errorWidget(BuildContext context, GoRouterState state) => Scaffold(
        body: Center(
          child: Text(
            'No route defined for ${state.uri.toString()} ',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      );

  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const SplashScreen(),
        ),
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        name: HomeScreen.name,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AddEmployeeDetailScreen.path,
        name: AddEmployeeDetailScreen.name,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: const AddEmployeeDetailScreen(),
        ),
        builder: (context, state) => const AddEmployeeDetailScreen(),
      ),
      GoRoute(
        path: EditEmployeeDetailScreen.path,
        name: EditEmployeeDetailScreen.name,
        pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
          context: context,
          state: state,
          child: EditEmployeeDetailScreen(
            employeeModel: state.extra as EmployeeModel,
          ),
        ),
        builder: (context, state) => EditEmployeeDetailScreen(
          employeeModel: state.extra as EmployeeModel,
        ),
      ),
    ],
    errorBuilder: errorWidget,
    redirect: (context, state) async {
      log('Redirecting ${state.uri.toString()}');
      return state.name;
    },
    navigatorKey: getIt<NavigationService>().navigatorKey,
    observers: [BotToastNavigatorObserver()],
  );

  static GoRouter get router => _router;
}

CupertinoPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  // cupertino page transition
  return CupertinoPage<T>(
    key: state.pageKey,
    child: child,
  );

  // return CustomTransitionPage<T>(
  //   key: state.pageKey,
  //   child: child,
  //   transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
  //       position: Tween<Offset>(
  //         begin: const Offset(1.0, 0.0),
  //         end: Offset.zero,
  //       ).animate(animation),
  //       child: child),
  //   transitionDuration: const Duration(milliseconds: 300),
  // );
}
