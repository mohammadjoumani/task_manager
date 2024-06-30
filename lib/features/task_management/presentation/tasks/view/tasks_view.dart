import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/app/app_prefs.dart';
import 'package:task_manager_app/core/app/di.dart';
import 'package:task_manager_app/core/utils/resource/color_manager.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/routes_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/resource/style_manager.dart';
import 'package:task_manager_app/core/utils/widgets/custom_scaffold.dart';
import 'package:task_manager_app/core/utils/widgets/generic_dialog.dart';
import 'package:task_manager_app/core/utils/widgets/margin.dart';
import 'package:task_manager_app/features/generic/presentation/main/bloc/main_bloc.dart';
import 'package:task_manager_app/features/task_management/presentation/tasks/bloc/tasks_bloc.dart';

import 'widgets/tasks_view_body.dart';

class TasksView extends StatelessWidget {
  TasksView({super.key});

  final AppPreferences _appPref = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<TasksBloc>()..add(GetTasksEvent()),
      child: CustomScaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _onPressedLogoutButton(context),
            icon: const Icon(Icons.logout),
          ),
          title: Text(AppStrings.strTasks.tr(context)),
          actions: [
            TextButton(
              onPressed: () => _onPressedLanguageCard(context),
              child: Row(
                children: [
                  Text(AppStrings.strCurrentLanguage.tr(context)),
                  const Sw2(),
                  const Icon(Icons.language),
                ],
              ),
            ),
          ],
        ),
        body: const TasksViewBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onPressedAddTodo(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _onPressedAddTodo(BuildContext context) {
    Navigator.pushNamed(context, Routes.addTaskRoute);
  }

  _onPressedLogoutButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => GenericDialog(
        dialogType: DialogType.confirmation,
        title: AppStrings.strLogout.tr(context),
        message: AppStrings.strAreYouSureYouWantToLogout.tr(context),
        labelButtonOne: AppStrings.strYes.tr(context),
        labelButtonTwo: AppStrings.strNo.tr(context),
        onPressedButtonOne: () {
          Navigator.pop(context);
          _appPref.logout();
          Navigator.pushNamedAndRemoveUntil(context, Routes.splashRoute, (route) => false);
        },
        onPressedButtonTwo: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _onPressedLanguageCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      enableDrag: true,
      useSafeArea: true,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              AppStrings.strArabic.tr(context),
              style: StyleManager.getRegularStyle(color: ColorManager.colorBlack),
            ),
            onTap: () {
              BlocProvider.of<MainBloc>(context).add(ChangeLanguageToArabic());
              Navigator.pop(context);
            },
            trailing: context.read<MainBloc>().state.locale == arabicLocale ? const Icon(Icons.check, color: ColorManager.colorPrimaryLight) : const SizedBox(),
          ),
          ListTile(
            title: Text(
              AppStrings.strEnglish.tr(context),
              style: StyleManager.getRegularStyle(color: ColorManager.colorBlack),
            ),
            onTap: () {
              BlocProvider.of<MainBloc>(context).add(ChangeLanguageToEnglish());
              Navigator.pop(context);
            },
            trailing: context.read<MainBloc>().state.locale == englishLocale ? const Icon(Icons.check, color: ColorManager.colorPrimaryLight) : const SizedBox(),
          ),
          const Sh4(),
        ],
      ),
    );
  }
}
