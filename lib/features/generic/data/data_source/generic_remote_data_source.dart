import 'package:task_manager_app/core/network/api_service.dart';

abstract class GenericRemoteDataSource {}

class GenericRemoteDataSourceImpl extends GenericRemoteDataSource {
  final ApiService _apiService;

  GenericRemoteDataSourceImpl(this._apiService);
}
