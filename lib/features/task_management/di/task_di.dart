import 'package:get_it/get_it.dart';
import 'package:task_manager_app/core/app/di.dart';
import 'package:task_manager_app/features/auth/domain/use_cases/get_users_use_case.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/add_task_use_case.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/delete_task_use_case.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/get_tasks_use_case.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/update_task_use_case.dart';
import 'package:task_manager_app/features/task_management/presentation/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_app/features/task_management/presentation/tasks/bloc/tasks_bloc.dart';

void initTasksModule() {
  if (!GetIt.I.isRegistered<GetTasksUseCase>()) {
    instance.registerFactory<GetTasksUseCase>(() => GetTasksUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<UpdateTaskUseCase>()) {
    instance.registerFactory<UpdateTaskUseCase>(() => UpdateTaskUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<DeleteTaskUseCase>()) {
    instance.registerFactory<DeleteTaskUseCase>(() => DeleteTaskUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<TasksBloc>()) {
    instance.registerFactory<TasksBloc>(() => TasksBloc(instance(), instance(), instance()));
  }
}

void initAddTaskModule() {
  if (!GetIt.I.isRegistered<GetUsersUseCase>()) {
    instance.registerFactory<GetUsersUseCase>(() => GetUsersUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<AddTaskUseCase>()) {
    instance.registerFactory<AddTaskUseCase>(() => AddTaskUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<AddTaskBloc>()) {
    instance.registerFactory<AddTaskBloc>(() => AddTaskBloc(instance(), instance()));
  }
}
