import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/utils/state_render/generic_data_state.dart';
import 'package:task_manager_app/core/utils/widgets/generic_failure.dart';
import 'package:task_manager_app/core/utils/widgets/generic_loading.dart';
import 'package:task_manager_app/core/utils/widgets/generic_pagination_list.dart';
import 'package:task_manager_app/features/task_management/presentation/tasks/bloc/tasks_bloc.dart';

import '../../../../domain/entities/task.dart';
import 'item_task.dart';

class TasksViewBody extends StatelessWidget {
  const TasksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        switch (state.getTodosDataState) {
          case GenericDataState.loading:
            return const Center(
              child: GenericLoading(),
            );
          case GenericDataState.success:
            return GenericPaginationList<Task>(
              items: state.tasks,
              itemBuilder: (context, index, item) {
                return ItemTask(
                  todo: item,
                );
              },
              onLoadMore: () {
                BlocProvider.of<TasksBloc>(context).add(GetMoreTasksEvent());
              },
              isLoading: state.getMoreTodosDataState == GenericMoreDataState.loading,
              isDone: state.getMoreTodosDataState == GenericMoreDataState.done,
              isError: state.getMoreTodosDataState == GenericMoreDataState.failure,
              error: state.failure?.message ?? '',
            );
          case GenericDataState.empty:
            return const Center(
              child: EmptyStateWidget(
                message: 'MMMMMMMM',
              ),
            );
          case GenericDataState.failure:
            return Center(
              child: GenericFailure(
                failure: state.failure,
                onTryAgain: () {
                  BlocProvider.of<TasksBloc>(context).add(GetTasksEvent());
                },
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
