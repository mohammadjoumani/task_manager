import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/font_manager.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';
import 'package:task_manager_app/core/utils/widgets/margin.dart';

import 'login_form.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Sh6(),
            Text(
              AppStrings.strWelcomeBack.tr(context),
              style: StyleManager.getBoldStyle(
                fontSize: FontSize.s30,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
            const Sh4(),
            Text(
              AppStrings.strPleaseEnterDataToLogin.tr(context),
              style: StyleManager.getRegularStyle(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            const Sh6(),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
