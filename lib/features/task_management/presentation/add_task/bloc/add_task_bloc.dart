import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/core/utils/state_render/generic_data_state.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';
import 'package:task_manager_app/features/auth/domain/use_cases/get_users_use_case.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/add_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/domain/entities/task.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/add_task_use_case.dart';

part 'add_task_event.dart';

part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final GetUsersUseCase _getUsersUseCase;
  final AddTaskUseCase _addTaskUseCase;

  AddTaskBloc(this._addTaskUseCase, this._getUsersUseCase) : super(AddTaskState()) {
    on<GetUsersEvent>(_mapGetUsers);
    on<GetAddTaskEvent>(_mapGetAddTask);
  }

  _mapGetUsers(GetUsersEvent event, Emitter<AddTaskState> emit) async {
    emit(state.copyWith(getUsersDataState: GenericDataState.loading));
    final result = await _getUsersUseCase.call(dartz.unit);
    result.fold(
      (l) => emit(state.copyWith(getUsersDataState: GenericDataState.failure, failure: l)),
      (r) => emit(state.copyWith(getUsersDataState: GenericDataState.success, users: r)),
    );
  }

  _mapGetAddTask(GetAddTaskEvent event, Emitter<AddTaskState> emit) async {
    emit(state.copyWith(addTaskDataState: GenericDataState.loading));
    final result = await _addTaskUseCase.call(event.task);
    result.fold(
      (l) => emit(state.copyWith(addTaskDataState: GenericDataState.failure, failure: l)),
      (r) => emit(state.copyWith(addTaskDataState: GenericDataState.success)),
    );
  }
}
