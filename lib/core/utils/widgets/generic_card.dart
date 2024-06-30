import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';

class GenericCard extends StatelessWidget {
  const GenericCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = ColorManager.colorWhite,
  });

  final Widget child;
  final GestureTapCallback? onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        shadows: const [ColorManager.genericBoxShadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSize.s8),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
