import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/get_todos_list_repo.dart';

class GetTodosListUsecase extends UseCase<List<Todo>, NoParams> {
  final GetTodosListRepo getTodosListRepo;

  GetTodosListUsecase({
    required this.getTodosListRepo,
  });
  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) {
    return getTodosListRepo.getTodosList();
  }
}
