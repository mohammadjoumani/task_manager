import 'package:dartz/dartz.dart';
import 'package:task_manager_app/core/app/app_prefs.dart';
import 'package:task_manager_app/core/network/error_handler.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_manager_app/features/auth/data/models/dto/request/login_request_dto.dart';
import 'package:task_manager_app/features/auth/data/models/dto/response/login_response_dto.dart';
import 'package:task_manager_app/features/auth/data/models/dto/response/user_response_dto.dart';
import 'package:task_manager_app/features/auth/data/models/mapper/login_response_mapper.dart';
import 'package:task_manager_app/features/auth/data/models/mapper/user_response_mapper.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';
import 'package:task_manager_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AppPreferences _appPref;

  AuthRepositoryImpl(this._authRemoteDataSource, this._appPref);

  @override
  Future<Either<Failure, User>> login(LoginRequestDto loginRequestDto) async {
    try {
      final response = await _authRemoteDataSource.login(loginRequestDto);
      final userInfo = LoginResponseDto.fromJson(response);
      _appPref.setUserInfo(userInfo);
      return Right(userInfo.toDomain());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      final response = await _authRemoteDataSource.getUsers();
      final users = UserResponseDto.fromJsonList(response['users']);
      return Right(users.toDomain());
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
