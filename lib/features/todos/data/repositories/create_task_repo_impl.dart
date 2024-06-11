import 'package:dartz/dartz.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../models/todo_model.dart';
import '../../domain/repositories/create_task_repo.dart';

import '../../../../core/network/network_info.dart';

class CreateTaskRepoImpl implements CreateTaskRepo {
  final ApiConsumer apiConsumer;
  final NetworkInfo networkInfo;

  CreateTaskRepoImpl({
    required this.apiConsumer,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TodoModel>> createTask({
    required CreateTaskParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiConsumer.post(
          path: EndPoints.todosList,
          body: {
            'image': params.image,
            'title': params.title,
            'desc': params.desc,
            'priority': params.priority,
            'dueDate': params.dueDate
          },
        );
        return Right(TodoModel.fromjson(response));
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
