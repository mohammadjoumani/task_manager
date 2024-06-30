import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/widgets/margin.dart';
import 'package:task_manager_app/features/auth/di/auth_di.dart';
import 'package:task_manager_app/features/auth/presentation/login/view/login_view.dart';
import 'package:task_manager_app/features/generic/presentation/on_boarding/view/on_boarding_view.dart';
import 'package:task_manager_app/features/generic/presentation/splash/view/splash_view.dart';
import 'package:task_manager_app/features/task_management/di/task_di.dart';
import 'package:task_manager_app/features/task_management/presentation/add_task/view/add_task_view.dart';
import 'package:task_manager_app/features/task_management/presentation/tasks/view/tasks_view.dart';

import 'string_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String tasksRoute = "/tasks";
  static const String addTaskRoute = "/add_task";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.tasksRoute:
        initTasksModule();
        return MaterialPageRoute(builder: (_) => TasksView());
      case Routes.addTaskRoute:
        initAddTaskModule();
        return MaterialPageRoute(builder: (_) => const AddTaskView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.strNoRouteFound.tr(context)),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'AssetsManager.imgDataNotFound',
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              const Sh4(),
              Text(
                AppStrings.strNoRouteFound.tr(context),
                style: const TextStyle(
                  color: Color(0xFFA0A0A0),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
