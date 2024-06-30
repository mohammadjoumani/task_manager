import 'package:task_manager_app/core/app/app_prefs.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/response/task_response_dto.dart';

abstract class TaskLocalDataSource {
  Future<dynamic> setTasks(List<TaskResponseDto> tasks);
  List<TaskResponseDto> getTasks();
}

class TaskLocalDataSourceImpl extends TaskLocalDataSource {
  final AppPreferences _appPref;

  TaskLocalDataSourceImpl(this._appPref);

  @override
  Future setTasks(List<TaskResponseDto> tasks) async {
    final result = _appPref.setTasks(tasks);
    return result;
  }

  @override
  List<TaskResponseDto> getTasks() {
    final result = _appPref.getTasks();
    print(result);
    return result;
  }
}
