part of 'add_task_bloc.dart';

class AddTaskState {
  final GenericDataState addTaskDataState;
  final GenericDataState getUsersDataState;
  final Task? task;
  final List<User> users;
  final Failure? failure;

  AddTaskState({
    this.addTaskDataState = GenericDataState.initial,
    this.getUsersDataState = GenericDataState.initial,
    this.task,
    this.users = const [],
    this.failure,
  });

  AddTaskState copyWith({
    GenericDataState? addTaskDataState,
    GenericDataState? getUsersDataState,
    Task? task,
    List<User>? users,
    Failure? failure,
  }) {
    return AddTaskState(
      addTaskDataState: addTaskDataState ?? this.addTaskDataState,
      getUsersDataState: getUsersDataState ?? this.getUsersDataState,
      task: task ?? this.task,
      users: users ?? this.users,
      failure: failure ?? this.failure,
    );
  }
}
