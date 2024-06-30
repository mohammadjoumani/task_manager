import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/app/di.dart';
import 'package:task_manager_app/core/utils/widgets/custom_scaffold.dart';
import 'package:task_manager_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<LoginBloc>(),
      child: const CustomScaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
