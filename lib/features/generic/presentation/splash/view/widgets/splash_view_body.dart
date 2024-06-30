import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_manager_app/core/app/app_prefs.dart';
import 'package:task_manager_app/core/app/constants.dart';
import 'package:task_manager_app/core/app/di.dart';
import 'package:task_manager_app/core/utils/resource/assets_manager.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/routes_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';
import 'package:task_manager_app/core/utils/widgets/generic_loading.dart';
import 'package:task_manager_app/core/utils/widgets/margin.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  final AppPreferences _appPref = instance<AppPreferences>();
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () => _goNext(context));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              AssetsManager.imgLogo,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const GenericLoading(),
                const Sh2(),
                // Version number
                Text(
                  'Version ${Constants.appVersion}',
                  textAlign: TextAlign.center,
                  style: StyleManager.getMediumStyle(color: ColorManager.colorGrey1),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _goNext(BuildContext context) async {
    if (_appPref.isUserLogged()) {
      Navigator.pushReplacementNamed(context, Routes.tasksRoute);
    } else if (_appPref.isOnBoardingScreenViewed()) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
    }
  }

// _checkUpdate(BuildContext context, bool isForceUpdate) {
// Future<void> _launchUrl(String url) async {
//   await launchUrlString(url);
// }
}
