part of 'tasks_bloc.dart';

class TasksState {
  final GenericDataState getTodosDataState;
  final GenericMoreDataState getMoreTodosDataState;
  final GenericDataState updateTodoDataState;
  final GenericDataState deleteTodoDataState;
  final List<Task> tasks;
  final int pageNumber;
  final Failure? failure;

  TasksState({
    this.getTodosDataState = GenericDataState.initial,
    this.getMoreTodosDataState = GenericMoreDataState.initial,
    this.updateTodoDataState = GenericDataState.initial,
    this.deleteTodoDataState = GenericDataState.initial,
    this.tasks = const [],
    this.pageNumber = 1,
    this.failure,
  });

  TasksState copyWith({
    GenericDataState? getTodosDataState,
    GenericMoreDataState? getMoreTodosDataState,
    GenericDataState? updateTodoDataState,
    GenericDataState? deleteTodoDataState,
    List<Task>? tasks,
    int? pageNumber,
    Failure? failure,
  }) {
    return TasksState(
      getTodosDataState: getTodosDataState ?? this.getTodosDataState,
      getMoreTodosDataState: getMoreTodosDataState ?? this.getMoreTodosDataState,
      updateTodoDataState: updateTodoDataState ?? this.updateTodoDataState,
      deleteTodoDataState: deleteTodoDataState ?? this.deleteTodoDataState,
      tasks: tasks ?? this.tasks,
      pageNumber: pageNumber ?? this.pageNumber,
      failure: failure ?? this.failure,
    );
  }
}
