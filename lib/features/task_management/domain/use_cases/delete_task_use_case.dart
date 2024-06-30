import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/generic/use_cases/use_case.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/task_management/domain/repository/task_repository.dart';

class DeleteTaskUseCase extends BaseUseCase<int, Unit> {
  final TaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  @override
  Future<Either<Failure, Unit>> call(int input) {
    return _taskRepository.deleteTask(input);
  }
}
