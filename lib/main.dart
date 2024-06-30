import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager_app/features/generic/presentation/main/view/task_manager_app.dart';

import 'core/app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
  await initAppModule();
  runApp(const TaskManagerApp());
}
