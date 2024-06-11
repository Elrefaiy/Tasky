import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../models/todo_model.dart';

abstract class GetTodosListRemoteDS {
  Future<List<TodoModel>> getTodosList();
}

class GetTodosListRemoteDSImpl implements GetTodosListRemoteDS {
  final ApiConsumer apiConsumer;

  GetTodosListRemoteDSImpl({
    required this.apiConsumer,
  });

  @override
  Future<List<TodoModel>> getTodosList() async {
    final List response = await apiConsumer.get(
      path: EndPoints.todosList,
    );
    List<TodoModel> responseAsModel = [];
    for (var element in response) {
      var model = TodoModel.fromjson(element);
      responseAsModel.add(model);
    }
    return responseAsModel;
  }
}
