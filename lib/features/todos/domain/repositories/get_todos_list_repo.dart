import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/todo.dart';

abstract class GetTodosListRepo {
  Future<Either<Failure, List<Todo>>> getTodosList();
}
