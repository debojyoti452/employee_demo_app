import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/core/di/di.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'src/core/extension/context_ext.dart';
import 'src/core/routes/app_routes.dart';
import 'src/presentation/screens/employee_details/cubit/employee_details_cubit.dart';
import 'src/presentation/screens/home/cubit/home_cubit.dart';
import 'src/presentation/utils/theme/app_theme.dart';
import 'src/presentation/widgets/custom_calendar/cubit/custom_calendar_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency injection
  await configureDependencies();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff0E8AD7),
    statusBarBrightness: Brightness.light,
  ));

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AppTheme(),
      ),
      BlocProvider(
        create: (context) => HomeCubit(),
      ),
      BlocProvider(
        create: (context) => CustomCalendarCubit(),
      ),
      BlocProvider(
        create: (context) => EmployeeDetailsCubit(),
      ),
    ],
    child: BaseApp(),
  ));
}

class BaseApp extends StatelessWidget {
  final botToastInit = BotToastInit();

  BaseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: context.designSize,
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: AppRoutes.router,
          locale: const Locale('en', ''),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          scrollBehavior: const MaterialScrollBehavior(),
          builder: (context, child) {
            child = botToastInit(context, child);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler:
                    context.isTablet ? const TextScaler.linear(1.5) : const TextScaler.linear(1.0),
              ),
              child: child,
            );
          },
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: context.watch<AppTheme>().state,
        );
      },
    );
  }
}
