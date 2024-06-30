import 'package:task_manager_app/core/network/api_service.dart';
import 'package:task_manager_app/core/network/constants_api.dart';
import 'package:task_manager_app/features/auth/data/models/dto/request/login_request_dto.dart';

abstract class AuthRemoteDataSource {
  Future<dynamic> login(LoginRequestDto loginRequestDto);

  Future<dynamic> getUsers();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<dynamic> login(LoginRequestDto loginRequestDto) async {
    final response = await _apiService.post(
      url: ConstantsApi.loginUrl,
      data: loginRequestDto.toJson(),
    );
    return response;
  }

  @override
  Future getUsers() async {
    final response = await _apiService.get(url: ConstantsApi.getAllUsersUrl);
    return response;
  }
}
