import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/routes_manager.dart';
import 'package:task_manager_app/core/utils/resource/theme_manager.dart';
import 'package:task_manager_app/features/generic/presentation/main/bloc/main_bloc.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (BuildContext context) => MainBloc(),
        ),
      ],
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Task Manager App',
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(state.fontSizeApp?.value ?? FontSizeAppEnum.small.value)),
                // data: MediaQuery.of(context).copyWith(textScaleFactor: state.fontSizeApp?.value ?? FontSizeAppEnum.small.value),
                child: child!,
              );
            },
            locale: state.locale,
            supportedLocales: const [englishLocale, arabicLocale],
            localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null && deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            theme: state.locale == arabicLocale ? ArabicLightModeTheme().themeData : EnglishLightModeTheme().themeData,
          );
        },
      ),
    );
  }
}
