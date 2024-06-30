part of 'login_bloc.dart';

class LoginState {
  final GenericDataState submitLoginDataState;
  final User? user;
  final bool isPasswordVisible;
  final String userName;
  final String password;
  final String emailValidationMessage;
  final String passwordValidatedMessage;
  final Failure? failure;

  LoginState({
    this.submitLoginDataState = GenericDataState.initial,
    this.user,
    this.isPasswordVisible = false,
    this.userName = '',
    this.password = '',
    this.emailValidationMessage = '',
    this.passwordValidatedMessage = '',
    this.failure,
  });

  LoginState copyWith({
    GenericDataState? submitLoginDataState,
    User? user,
    bool? isPasswordVisible,
    String? email,
    String? password,
    String? emailValidationMessage,
    String? passwordValidatedMessage,
    Failure? failure,
  }) {
    return LoginState(
      submitLoginDataState: submitLoginDataState ?? this.submitLoginDataState,
      user: user ?? this.user,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      userName: email ?? this.userName,
      password: password ?? this.password,
      emailValidationMessage: emailValidationMessage ?? this.emailValidationMessage,
      passwordValidatedMessage: passwordValidatedMessage ?? this.passwordValidatedMessage,
      failure: failure ?? this.failure,
    );
  }
}
