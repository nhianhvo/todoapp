import 'package:todoapp/data_source/remote/api_client.dart';
import 'package:todoapp/data_source/share/base_repo.dart';
import 'package:todoapp/data_source/share/base_repo_impl.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:injectable/injectable.dart';

abstract class TodoRepo extends BaseRepo {
  Future<List<ToDoResponse>> getListTodo();
}

@Singleton(as: TodoRepo)
class TodoRepoImpl extends BaseRepoImpl implements TodoRepo {
  ApiClient apiClient;

  TodoRepoImpl(this.apiClient);

  String url = ApiEndpoint.END_POINT + ApiEndpoint.API_PREFIX;

  @override
  Future<List<ToDoResponse>> getListTodo() async {
    // var response = await apiClient.get(path: '$url/todo/getListTodo');
    // var data = response.data as List<ToDoResponse>;

    var data = todoList();
    return data;
  }

  static List<ToDoResponse> todoList() {
    return [
      ToDoResponse(id: 1, todoName: 'Morning Excercise', isDone: true),
      ToDoResponse(id: 2, todoName: 'Buy Groceries', isDone: true),
      ToDoResponse(
        id: 3,
        todoName: 'Check Emails',
      ),
      ToDoResponse(
        id: 4,
        todoName: 'Team Meeting',
      ),
      ToDoResponse(
        id: 5,
        todoName: 'Work on mobile apps for 2 hour',
      ),
      ToDoResponse(
        id: 6,
        todoName: 'Dinner with Jenny',
      ),
    ];
  }
}
