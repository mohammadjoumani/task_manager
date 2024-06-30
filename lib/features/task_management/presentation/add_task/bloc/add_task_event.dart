part of 'add_task_bloc.dart';

sealed class AddTaskEvent {}

class GetUsersEvent extends AddTaskEvent {}

class GetAddTaskEvent extends AddTaskEvent {
  final AddTaskRequestDto task;

  GetAddTaskEvent(this.task);
}
