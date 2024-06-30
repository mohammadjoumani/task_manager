import 'dart:core';

import 'package:task_manager_app/core/app/constants.dart';
import 'package:task_manager_app/core/app/extensions.dart';
import 'package:task_manager_app/features/auth/data/models/dto/response/login_response_dto.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';

extension LoginResponseMapper on LoginResponseDto {
  User toDomain() {
    return User(
      id?.orZero() ?? Constants.zero,
      username?.orEmpty() ?? Constants.empty,
      email?.orEmpty() ?? Constants.empty,
      firstName?.orEmpty() ?? Constants.empty,
      lastName?.orEmpty() ?? Constants.empty,
      gender?.orEmpty() ?? Constants.empty,
      image?.orEmpty() ?? Constants.empty,
    );
  }
}
