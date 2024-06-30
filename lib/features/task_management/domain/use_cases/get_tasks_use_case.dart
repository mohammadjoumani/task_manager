import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/generic/use_cases/use_case.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/task_management/domain/repository/task_repository.dart';

import '../entities/task.dart' as todo;

class GetTasksUseCase extends BaseUseCase<int, List<todo.Task>> {
  final TaskRepository _taskRepository;

  GetTasksUseCase(this._taskRepository);

  @override
  Future<Either<Failure, List<todo.Task>>> call(int input) {
    return _taskRepository.getTasks(input);
  }
}
