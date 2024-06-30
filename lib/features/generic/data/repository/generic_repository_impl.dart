import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/generic/data/data_source/generic_remote_data_source.dart';
import 'package:task_manager_app/features/generic/domain/repository/generic_repository.dart';

class GenericRepositoryImpl extends GenericRepository {
  final GenericRemoteDataSource _genericRemoteDataSource;
  final NetworkInfo _networkInfo;

  GenericRepositoryImpl(this._genericRemoteDataSource, this._networkInfo);

  // @override
  // Future<Either<Failure, List<NotificationMessage>>> getNotifications(int pageNumber) async {
  //   if (await _networkInfo.isConnected) {
  //     try {
  //       final response = await _genericRemoteDataSource.getNotifications(pageNumber);
  //       return right(NotificationResponseDto.fromJsonList(response['rows']).toDomain());
  //     } catch (error) {
  //       return Left(ErrorHandler.handle(error).failure);
  //     }
  //   } else {
  //     return Left(DataSource.noInternetConnection.getFailure());
  //   }
  // }
}
