import 'package:dartz/dartz.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/repositories/edit_task_repo.dart';

class EditTaskRepoImpl implements EditTaskRepo {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;

  EditTaskRepoImpl({
    required this.apiConsumer,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> editTask({
    required EditTaskParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        await apiConsumer.put(
          path: EndPoints.taskDetails(id: params.id),
          body: params.data,
        );
        return const Right('Updated Successfully');
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
