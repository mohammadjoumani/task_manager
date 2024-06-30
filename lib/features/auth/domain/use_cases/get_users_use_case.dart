import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/generic/use_cases/use_case.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';
import 'package:task_manager_app/features/auth/domain/repository/auth_repository.dart';

class GetUsersUseCase extends BaseUseCase<Unit, List<User>> {
  final AuthRepository _authRepository;

  GetUsersUseCase(this._authRepository);

  @override
  Future<Either<Failure, List<User>>> call(Unit input) {
    return _authRepository.getUsers();
  }
}
