import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/todo.dart';
import '../repositories/get_task_details_repo.dart';

class GetTaskDetailsUsecase extends UseCase<Todo, String> {
  final GetTaskDetailsRepo getTaskDetailsRepo;

  GetTaskDetailsUsecase({required this.getTaskDetailsRepo});
  @override
  Future<Either<Failure, Todo>> call(String params) {
    return getTaskDetailsRepo.getTaskDetails(params: params);
  }
}
