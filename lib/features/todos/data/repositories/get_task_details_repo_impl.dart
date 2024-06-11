import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/get_task_details_remote_ds.dart';
import '../models/todo_model.dart';
import '../../domain/repositories/get_task_details_repo.dart';

class GetTaskDetailsRepoImpl implements GetTaskDetailsRepo {
  final NetworkInfo networkInfo;
  final GetTaskDetailsRemoteDS remoteDS;

  GetTaskDetailsRepoImpl({
    required this.networkInfo,
    required this.remoteDS,
  });
  @override
  Future<Either<Failure, TodoModel>> getTaskDetails({
    required String params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDS.getTaskDetails(id: params);
        return Right(response);
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
