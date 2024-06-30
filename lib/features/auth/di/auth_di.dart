import 'package:get_it/get_it.dart';
import 'package:task_manager_app/core/app/di.dart';
import 'package:task_manager_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:task_manager_app/features/auth/presentation/login/bloc/login_bloc.dart';

void initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
  }
  if (!GetIt.I.isRegistered<LoginBloc>()) {
    instance.registerFactory<LoginBloc>(() => LoginBloc(instance()));
  }
}
