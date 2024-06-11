import 'package:dartz/dartz.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/delete_task_repo.dart';

class DeleteTaskRepoImpl implements DeleteTaskRepo {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;

  DeleteTaskRepoImpl({
    required this.apiConsumer,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> deleteTask({
    required String id,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await apiConsumer.delete(
          path: EndPoints.taskDetails(id: id),
        );
        return const Right('Task Deleted!');
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
