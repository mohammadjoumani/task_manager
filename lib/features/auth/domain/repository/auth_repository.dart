import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/auth/data/models/dto/request/login_request_dto.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginRequestDto loginRequestDto);

  Future<Either<Failure, List<User>>> getUsers();
}
