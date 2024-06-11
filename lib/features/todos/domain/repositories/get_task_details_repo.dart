import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/todo.dart';

abstract class GetTaskDetailsRepo {
  Future<Either<Failure, Todo>> getTaskDetails({
    required String params,
  });
}
