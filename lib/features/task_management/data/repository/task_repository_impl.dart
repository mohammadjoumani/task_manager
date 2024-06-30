import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/network/error_handler.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/task_management/data/data_source/task_local_data_source.dart';
import 'package:task_manager_app/features/task_management/data/data_source/task_remote_data_source.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/add_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/update_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/response/task_response_dto.dart';
import 'package:task_manager_app/features/task_management/data/models/mapper/task_response_mapper.dart';
import 'package:task_manager_app/features/task_management/domain/repository/task_repository.dart';

import '../../domain/entities/task.dart' as todo;

class TaskRepositoryImpl extends TaskRepository {
  final TaskRemoteDataSource _taskRemoteDataSource;
  final TaskLocalDataSource _taskLocalDataSource;

  TaskRepositoryImpl(this._taskRemoteDataSource, this._taskLocalDataSource);

  @override
  Future<Either<Failure, List<todo.Task>>> getTasks(int pageNumber) async {
    try {
      final response = await _taskRemoteDataSource.getTasks(pageNumber);
      final tasks = TaskResponseDto.fromJsonList(response['todos']);
      _taskLocalDataSource.setTasks(tasks);
      return Right(tasks.toDomain());
    } catch (error) {
      List<TaskResponseDto> localTasks = [];
      if (pageNumber == 1) {
        localTasks = _taskLocalDataSource.getTasks();
      }
      if (localTasks.isNotEmpty) {
        return Right(localTasks.toDomain());
      } else {
        return Left(ErrorHandler.handle(error).failure);
      }
    }
  }

  @override
  Future<Either<Failure, todo.Task>> addTask(AddTaskRequestDto addTaskRequestDto) async {
    try {
      final response = await _taskRemoteDataSource.addTask(addTaskRequestDto);
      final todo = TaskResponseDto.fromJson(response).toDomain();
      return Right(todo);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, todo.Task>> updateTask(UpdateTaskRequestDto updateTaskRequestDto) async {
    try {
      final response = await _taskRemoteDataSource.updateTask(updateTaskRequestDto);
      final todo = TaskResponseDto.fromJson(response).toDomain();
      return Right(todo);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(int id) async {
    try {
      await _taskRemoteDataSource.deleteTask(id);
      return const Right(unit);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
