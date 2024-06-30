import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/generic/use_cases/use_case.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/update_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/domain/repository/task_repository.dart';

import '../entities/task.dart'as todo;

class UpdateTaskUseCase extends BaseUseCase<UpdateTaskRequestDto, todo.Task> {
  final TaskRepository _taskRepository;

  UpdateTaskUseCase(this._taskRepository);

  @override
  Future<Either<Failure, todo.Task>> call(UpdateTaskRequestDto input) {
    return _taskRepository.updateTask(input);
  }
}
