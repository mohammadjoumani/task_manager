part of 'login_bloc.dart';

abstract class LoginEvent {}

class SubmitLoginEvent extends LoginEvent {}

class ChangePasswordVisibilityEvent extends LoginEvent {}

class ChangeUserNameEvent extends LoginEvent {
  final String userName;

  ChangeUserNameEvent(this.userName);
}

class ChangePasswordEvent extends LoginEvent {
  final String password;

  ChangePasswordEvent(this.password);
}
