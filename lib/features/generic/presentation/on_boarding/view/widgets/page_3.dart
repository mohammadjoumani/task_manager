import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_app/core/utils/resource/assets_manager.dart';
import 'package:task_manager_app/core/utils/resource/font_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/widgets/margin.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: SvgPicture.asset(AssetsManager.imgOnboarding3),
        ),
      ],
    );
  }
}

class OnBoardingText3 extends StatelessWidget {
  const OnBoardingText3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.strOnBoardingTitle3,
          textAlign: TextAlign.center,
          style: StyleManager.getBoldStyle(
            fontSize: FontSize.s20,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        const Sh2(),
        Text(
          AppStrings.strOnBoardingBody3,
          textAlign: TextAlign.center,
          style: StyleManager.getRegularStyle(
            fontSize: FontSize.s16,
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ],
    );
  }
}
