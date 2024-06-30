import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/font_manager.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';
import 'package:task_manager_app/core/utils/widgets/generic_dialog.dart';
import 'package:task_manager_app/core/utils/widgets/generic_icon_button.dart';
import 'package:task_manager_app/core/utils/widgets/generic_loading.dart';
import 'package:task_manager_app/core/utils/widgets/margin.dart';
import 'package:task_manager_app/features/task_management/presentation/tasks/bloc/tasks_bloc.dart';

import '../../../../domain/entities/task.dart';

class ItemTask extends StatelessWidget {
  const ItemTask({super.key, required this.todo});

  final Task todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: todo.completed ? ColorManager.colorPrimaryLight : ColorManager.colorError,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        shadows: const [ColorManager.genericBoxShadow],
      ),
      child: Container(
        margin: const EdgeInsetsDirectional.only(start: AppMargin.m16),
        decoration: const ShapeDecoration(
          color: ColorManager.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(AppSize.s8)),
          ),
          shadows: [ColorManager.genericBoxShadow],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            children: [
              Expanded(
                child: Text.rich(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  TextSpan(
                    text: '${todo.id}- ',
                    style: StyleManager.getMediumStyle(
                      color: ColorManager.colorBlack,
                      fontSize: FontSize.s16,
                    ),
                    children: [
                      TextSpan(text: todo.todo),
                    ],
                  ),
                ),
              ),
              const Sw2(),
              if (todo.isLoading) ...{
                const GenericLoading()
              } else ...{
                SizedBox(
                  height: AppSize.s34,
                  width: AppSize.s34,
                  child: GenericIconButton(
                    onPressed: () => _onPressedMenuButton(context),
                    icon: const Icon(
                      Icons.more_vert,
                      color: ColorManager.colorBlack,
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }

  _onPressedMenuButton(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(AppStrings.strEdit.tr(context)),
            onTap: () {
              Navigator.pop(context);
              _confirmUpdateDialog(context);
            },
          ),
          ListTile(
            title: Text(AppStrings.strDelete.tr(context)),
            onTap: () {
              Navigator.pop(context);
              _confirmDeleteDialog(context);
            },
          ),
          const Sh2(),
        ],
      ),
    );
  }

  _confirmUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => GenericDialog(
        dialogType: DialogType.confirmation,
        title: AppStrings.strEdit.tr(context),
        message: AppStrings.strAreYouSureEdit.tr(context),
        labelButtonOne: AppStrings.strYes.tr(context),
        labelButtonTwo: AppStrings.strNo.tr(context),
        onPressedButtonOne: () {
          Navigator.pop(context);
          context.read<TasksBloc>().add(UpdateTaskEvent(todo));
        },
        onPressedButtonTwo: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _confirmDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => GenericDialog(
        dialogType: DialogType.delete,
        title: AppStrings.strDelete.tr(context),
        message: AppStrings.strAreYouSureDelete.tr(context),
        labelButtonOne: AppStrings.strYes.tr(context),
        labelButtonTwo: AppStrings.strNo.tr(context),
        onPressedButtonOne: () {
          Navigator.pop(context);
          context.read<TasksBloc>().add(DeleteTaskEvent(todo));
        },
        onPressedButtonTwo: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
