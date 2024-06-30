import 'package:device_info_plus/device_info_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/network/api_service.dart';
import 'package:task_manager_app/core/network/dio_factory.dart';
import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_manager_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_manager_app/features/auth/domain/repository/auth_repository.dart';
import 'package:task_manager_app/features/generic/data/data_source/generic_remote_data_source.dart';
import 'package:task_manager_app/features/generic/data/repository/generic_repository_impl.dart';
import 'package:task_manager_app/features/generic/domain/repository/generic_repository.dart';
import 'package:task_manager_app/features/task_management/data/data_source/task_local_data_source.dart';
import 'package:task_manager_app/features/task_management/data/data_source/task_remote_data_source.dart';
import 'package:task_manager_app/features/task_management/data/repository/task_repository_impl.dart';
import 'package:task_manager_app/features/task_management/domain/repository/task_repository.dart';

import 'app_prefs.dart';
import 'device_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Device Info
  final deviceInfoPlugin = DeviceInfoPlugin();
  instance.registerLazySingleton<DeviceInfo>(() => DeviceInfoImpl(deviceInfoPlugin));

  // SharedPreferences instance
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // AppPreferences instance
  // final appPreferences = AppPreferences(instance());
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  // Dio
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio1 = await instance<DioFactory>().getDio();
  final dio2 = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<ApiService>(() => ApiService(dio1, dio2, instance(), instance()));

  //Generic RemoteDataSource instance
  instance.registerLazySingleton<GenericRemoteDataSource>(() => GenericRemoteDataSourceImpl(instance()));

  //Generic Repository instance
  instance.registerLazySingleton<GenericRepository>(() => GenericRepositoryImpl(instance(), instance()));

  //Auth RemoteDataSource instance
  instance.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(instance()));

  //Auth Repository instance
  instance.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(instance(), instance()));

  //Task RemoteDataSource instance
  instance.registerLazySingleton<TaskRemoteDataSource>(() => TaskRemoteDataSourceImpl(instance()));

  //Task RemoteDataSource instance
  instance.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl(instance()));

  //Task Repository instance
  instance.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(instance(), instance()));
}
