import 'package:task_manager_app/core/app/constants.dart';
import 'package:task_manager_app/core/network/api_service.dart';
import 'package:task_manager_app/core/network/constants_api.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/add_task_request_dto.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/request/update_task_request_dto.dart';

abstract class TaskRemoteDataSource {
  Future<dynamic> getTasks(int pageNumber);

  Future<dynamic> addTask(AddTaskRequestDto addTaskRequestDto);

  Future<dynamic> updateTask(UpdateTaskRequestDto updateTaskRequestDto);

  Future<dynamic> deleteTask(int id);
}

class TaskRemoteDataSourceImpl extends TaskRemoteDataSource {
  final ApiService _apiService;

  TaskRemoteDataSourceImpl(this._apiService);

  @override
  Future<dynamic> getTasks(int pageNumber) async {
    final response = await _apiService.get(
      url: ConstantsApi.todosUrl,
      params: {
        'limit': Constants.pageSize,
        'skip': (pageNumber - 1) * Constants.pageSize,
      },
    );
    return response;
  }

  @override
  Future addTask(AddTaskRequestDto addTaskRequestDto) async {
    final response = await _apiService.post(
      url: ConstantsApi.addTodoUrl,
      data: addTaskRequestDto.toJson(),
    );
    return response;
  }

  @override
  Future updateTask(UpdateTaskRequestDto updateTaskRequestDto) async {
    final response = await _apiService.put(
      url: '${ConstantsApi.updateTodoUrl}/${updateTaskRequestDto.id}',
      data: {
        'completed': updateTaskRequestDto.isCompleted,
      },
    );
    return response;
  }

  @override
  Future deleteTask(int id) async {
    final response = await _apiService.delete(
      url: '${ConstantsApi.updateTodoUrl}/$id',
    );
    return response;
  }
}
