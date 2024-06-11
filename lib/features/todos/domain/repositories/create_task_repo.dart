import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';

import '../../../../core/errors/failure.dart';

abstract class CreateTaskRepo {
  Future<Either<Failure, Todo>> createTask({
    required CreateTaskParams params,
  });
}
