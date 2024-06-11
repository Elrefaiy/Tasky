import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';

abstract class EditTaskRepo {
  Future<Either<Failure, String>> editTask({
    required EditTaskParams params,
  });
}
