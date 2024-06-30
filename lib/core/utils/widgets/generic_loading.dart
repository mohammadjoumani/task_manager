import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/resource/values_manager.dart';
import 'package:task_manager_app/features/generic/presentation/main/view/task_manager_app.dart';

class GenericLoading extends StatelessWidget {
  const GenericLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: AppSize.s2,
    );
  }
}

void fullScreenLoading() {
  final context = navigatorKey!.currentState!.context;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const PopScope(
      canPop: false,
      child: Center(child: GenericLoading()),
    ),
  );
}
