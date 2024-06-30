import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';

import 'generic_button.dart';
import 'margin.dart';

enum DialogType { delete, confirmation }

class GenericDialog extends StatelessWidget {
  const GenericDialog({
    super.key,
    required this.dialogType,
    required this.title,
    required this.message,
    required this.labelButtonOne,
    required this.labelButtonTwo,
    required this.onPressedButtonOne,
    required this.onPressedButtonTwo,
  });

  final DialogType dialogType;
  final String title;
  final String message;
  final String labelButtonOne;
  final String labelButtonTwo;
  final VoidCallback onPressedButtonOne;
  final VoidCallback onPressedButtonTwo;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.colorBackgroundLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                featureIcon(dialogType),
                const Sw3(),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: StyleManager.getMediumStyle(color: ColorManager.colorBlack),
                      ),
                      Text(
                        message,
                        style: StyleManager.getRegularStyle(color: ColorManager.colorGrey1),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Sh4(),

            //Buttons
            Row(
              children: [
                Expanded(
                  child: GenericButton(
                    label: AppStrings.strNo.tr(context),
                    onPressed: onPressedButtonTwo,
                    buttonType: ButtonType.outline,
                    buttonSize: ButtonSize.small,
                  ),
                ),
                const Sw3(),
                Expanded(
                  child: GenericButton(
                    label: AppStrings.strYes.tr(context),
                    onPressed: onPressedButtonOne,
                    buttonType: ButtonType.solid,
                    buttonSize: ButtonSize.small,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  featureIcon(DialogType dialogType) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: dialogType == DialogType.confirmation ? ColorManager.colorPrimaryLight.withOpacity(0.1) : ColorManager.colorError.withOpacity(0.1), shape: BoxShape.circle),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: dialogType == DialogType.confirmation ? ColorManager.colorPrimaryLight.withOpacity(0.2) : ColorManager.colorError.withOpacity(0.2),
              width: AppSize.s4,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.error_outline,
              color: dialogType == DialogType.confirmation ? ColorManager.colorPrimaryLight : ColorManager.colorError,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
