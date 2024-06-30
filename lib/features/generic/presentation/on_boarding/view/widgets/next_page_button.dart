import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';

class NextPageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextPageButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: const EdgeInsets.all(AppPadding.p16),
      elevation: 0.0,
      shape: const CircleBorder(),
      fillColor: Theme.of(context).primaryColor,
      onPressed: onPressed,
      child: const Icon(
        Icons.arrow_forward,
        color: ColorManager.colorWhite,
        size: AppSize.s28,
      ),
    );
  }
}
