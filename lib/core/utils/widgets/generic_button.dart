import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';
import 'margin.dart';

enum ButtonSize { small, large }

enum ButtonType { solid, outline }

class GenericButton extends StatelessWidget {
  const GenericButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.buttonType = ButtonType.solid,
    this.buttonSize = ButtonSize.large,
    this.assetsIcon,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final ButtonType buttonType;
  final ButtonSize buttonSize;
  final String? assetsIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonSize == ButtonSize.small ? AppSize.s40 : AppSize.s48,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
            side: buttonType == ButtonType.solid
                ? BorderSide.none
                : const BorderSide(
                    color: ColorManager.colorBlack,
                    width: AppSize.s1,
                  ),
          ),
          backgroundColor: buttonType == ButtonType.solid ? ColorManager.colorPrimaryLight : ColorManager.colorWhite,
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: AppSize.s24,
                height: AppSize.s24,
                child: CircularProgressIndicator(
                  color: ColorManager.colorWhite,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  assetsIcon == null
                      ? const SizedBox()
                      : Row(
                          children: [
                            SvgPicture.asset(
                              assetsIcon!,
                              width: AppSize.s20,
                              height: AppSize.s20,
                            ),
                            const Sw3(),
                          ],
                        ),
                  Text(
                    label,
                    style: StyleManager.getSemiBoldStyle(
                      color: buttonType == ButtonType.solid ? ColorManager.colorWhite : ColorManager.colorBlack,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
