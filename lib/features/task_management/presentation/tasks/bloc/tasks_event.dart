part of 'tasks_bloc.dart';

sealed class TasksEvent {}

class GetTasksEvent extends TasksEvent {}

class GetMoreTasksEvent extends TasksEvent {}

class UpdateTaskEvent extends TasksEvent {
  final Task task;

  UpdateTaskEvent(this.task);
}

class DeleteTaskEvent extends TasksEvent {
  final Task task;

  DeleteTaskEvent(this.task);
}
