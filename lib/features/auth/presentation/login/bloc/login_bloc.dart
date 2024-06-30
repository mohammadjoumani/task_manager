import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/network/failure.dart';
import 'package:task_manager_app/core/utils/state_render/generic_data_state.dart';
import 'package:task_manager_app/features/auth/data/models/dto/request/login_request_dto.dart';
import 'package:task_manager_app/features/auth/domain/entities/user.dart';
import 'package:task_manager_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:task_manager_app/features/auth/domain/use_cases/validate_user_name_use_case.dart';
import 'package:task_manager_app/features/auth/domain/use_cases/validate_password_use_case.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final _validateUserNameUseCase = ValidateUserNameUseCase();
  final _validatePasswordUseCase = ValidatePasswordUseCase();

  LoginBloc(this._loginUseCase) : super(LoginState()) {
    on<SubmitLoginEvent>(_mapSubmitLogin);
    on<ChangePasswordVisibilityEvent>(_mapChangePasswordVisibility);
    on<ChangeUserNameEvent>(_mapChangeUserName);
    on<ChangePasswordEvent>(_mapChangePassword);
  }

  _mapSubmitLogin(SubmitLoginEvent event, Emitter<LoginState> emit) async {
    final validateEmail = await _validateUserNameUseCase.call(state.userName);
    final validatePassword = await _validatePasswordUseCase.call(state.password);
    if (validateEmail.isNotEmpty && validatePassword.isNotEmpty) {
      emit(state.copyWith(emailValidationMessage: validateEmail, passwordValidatedMessage: validatePassword));
    } else if (validateEmail.isNotEmpty) {
      emit(state.copyWith(emailValidationMessage: validateEmail));
    } else if (validatePassword.isNotEmpty) {
      emit(state.copyWith(passwordValidatedMessage: validatePassword));
    } else {
      emit(state.copyWith(submitLoginDataState: GenericDataState.loading));
      final result = await _loginUseCase.call(
        LoginRequestDto(
          userName: state.userName,
          password: state.password,
        ),
      );
      result.fold(
        (l) => emit(state.copyWith(submitLoginDataState: GenericDataState.failure, failure: l)),
        (r) => emit(state.copyWith(submitLoginDataState: GenericDataState.success)),
      );
    }
  }

  _mapChangePasswordVisibility(ChangePasswordVisibilityEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  _mapChangeUserName(ChangeUserNameEvent event, Emitter<LoginState> emit) async {
    final result = await _validateUserNameUseCase.call(event.userName);
    emit(state.copyWith(emailValidationMessage: result, email: event.userName));
  }

  _mapChangePassword(ChangePasswordEvent event, Emitter<LoginState> emit) async {
    final result = await _validatePasswordUseCase.call(event.password);
    emit(state.copyWith(passwordValidatedMessage: result, password: event.password));
  }
}
