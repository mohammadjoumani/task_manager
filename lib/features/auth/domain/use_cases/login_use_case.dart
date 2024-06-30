import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/generic/use_cases/use_case.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/auth/data/models/dto/request/login_request_dto.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';
import 'package:task_manager_app/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase extends BaseUseCase<LoginRequestDto, User> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Either<Failure, User>> call(LoginRequestDto input) {
    return _authRepository.login(input);
  }
}
