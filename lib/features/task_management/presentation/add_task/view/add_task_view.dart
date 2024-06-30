import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/app/di.dart';
import 'package:task_manager_app/core/utils/resource/language_manager.dart';
import 'package:task_manager_app/core/utils/resource/string_manager.dart';
import 'package:task_manager_app/core/utils/widgets/custom_scaffold.dart';
import 'package:task_manager_app/features/task_management/presentation/add_task/bloc/add_task_bloc.dart';

import 'widgets/add_task_view_body.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => instance<AddTaskBloc>()..add(GetUsersEvent()),
      child: CustomScaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(AppStrings.strAdd.tr(context)),
        ),
        body: const AddTaskViewBody(),
      ),
    );
  }
}
