import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/get_todos_list_remote_ds.dart';
import '../models/todo_model.dart';
import '../../domain/repositories/get_todos_list_repo.dart';

class GetTodosListRepoImpl implements GetTodosListRepo {
  final NetworkInfo networkInfo;
  final GetTodosListRemoteDS remoteDS;

  GetTodosListRepoImpl({
    required this.networkInfo,
    required this.remoteDS,
  });

  @override
  Future<Either<Failure, List<TodoModel>>> getTodosList() async {
    if (await networkInfo.isConnected) {
      try {
        final List<TodoModel> response = await remoteDS.getTodosList();
        return Right(response);
      } catch (error) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
