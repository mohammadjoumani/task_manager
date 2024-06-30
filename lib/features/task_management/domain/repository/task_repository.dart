import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/add_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/update_task_request_dto.dart';

import '../entities/task.dart' as todo;

abstract class TaskRepository {
  Future<Either<Failure, List<todo.Task>>> getTasks(int pageNumber);

  Future<Either<Failure, todo.Task>> addTask(AddTaskRequestDto addTaskRequestDto);

  Future<Either<Failure, todo.Task>> updateTask(UpdateTaskRequestDto updateTaskRequestDto);

  Future<Either<Failure, Unit>> deleteTask(int id);
}
