import 'package:task_manager_app/core/app/constants.dart';
import 'package:task_manager_app/core/app/extensions.dart';
import 'package:task_manager_app/features/task_management/data/models/dto/response/task_response_dto.dart';

import '../../../domain/entities/task.dart';

extension TaskResponseMapper on TaskResponseDto {
  Task toDomain() {
    return Task(
      id?.orZero() ?? Constants.zero,
      todo?.orEmpty() ?? Constants.empty,
      completed?.orFalse() ?? Constants.falseValue,
      userId?.orZero() ?? Constants.zero,
    );
  }
}

extension TaskListResponseMapper on List<TaskResponseDto> {
  List<Task> toDomain() {
    return map((item) => item.toDomain()).toList();
  }
}
