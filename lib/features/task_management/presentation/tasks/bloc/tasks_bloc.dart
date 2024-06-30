import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/core/utils/state_render/generic_data_state.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/update_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/domain/entities/task.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/delete_task_use_case.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/get_tasks_use_case.dart';
import 'package:task_manager_app/features/task_management/domain/use_cases/update_task_use_case.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksUseCase _getTasksUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TasksBloc(this._getTasksUseCase, this._updateTaskUseCase, this._deleteTaskUseCase) : super(TasksState()) {
    on<GetTasksEvent>(_mapGetTasks);
    on<GetMoreTasksEvent>(_mapGetMoreTasks);

    on<UpdateTaskEvent>(_mapUpdateTask);
    on<DeleteTaskEvent>(_mapDeleteTask);
  }

  _mapGetTasks(GetTasksEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(getTodosDataState: GenericDataState.loading));
    final result = await _getTasksUseCase.call(1);
    result.fold(
      (l) => emit(state.copyWith(getTodosDataState: GenericDataState.failure, failure: l)),
      (r) {
        r.isEmpty
            ? emit(state.copyWith(getTodosDataState: GenericDataState.empty))
            : emit(
                state.copyWith(
                  getTodosDataState: GenericDataState.success,
                  tasks: r,
                  pageNumber: 2,
                ),
              );
      },
    );
  }

  _mapGetMoreTasks(GetMoreTasksEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(getMoreTodosDataState: GenericMoreDataState.loading));
    final result = await _getTasksUseCase.call(state.pageNumber);
    result.fold(
      (l) => emit(state.copyWith(getMoreTodosDataState: GenericMoreDataState.failure, failure: l)),
      (r) {
        if (r.isEmpty) {
          emit(state.copyWith(getMoreTodosDataState: GenericMoreDataState.done));
        } else {
          final newList = state.tasks;
          newList.addAll(r);
          final newPageNumber = state.pageNumber + 1;
          emit(
            state.copyWith(
              getMoreTodosDataState: GenericMoreDataState.success,
              tasks: newList,
              pageNumber: newPageNumber,
            ),
          );
        }
      },
    );
  }

  _mapUpdateTask(UpdateTaskEvent event, Emitter<TasksState> emit) async {
    event.task.isLoading = true;
    emit(state.copyWith(updateTodoDataState: GenericDataState.loading));
    final result = await _updateTaskUseCase.call(UpdateTaskRequestDto(id: event.task.id, isCompleted: !event.task.completed));
    result.fold(
      (l) => emit(state.copyWith(updateTodoDataState: GenericDataState.failure, failure: l)),
      (r) {
        event.task.completed = r.completed;
        emit(state.copyWith(updateTodoDataState: GenericDataState.success));
      },
    );
    event.task.isLoading = false;
  }

  _mapDeleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) async {
    event.task.isLoading = true;
    emit(state.copyWith(deleteTodoDataState: GenericDataState.loading));
    final result = await _deleteTaskUseCase.call(event.task.id);
    result.fold(
      (l) => emit(state.copyWith(deleteTodoDataState: GenericDataState.failure, failure: l)),
      (r) {
        final newList = state.tasks;
        newList.removeWhere((element) => element.id == event.task.id);
        emit(state.copyWith(deleteTodoDataState: GenericDataState.success, tasks: newList));
      },
    );
    event.task.isLoading = false;
  }
}
