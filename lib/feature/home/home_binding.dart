import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/data_source/repository/todo_repo.dart';
import 'package:todoapp/model/todo_model.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(GetIt.instance.get<TodoRepo>()));
  }
}

class HomeController extends GetxController {
  final TodoRepo _todoRepo;
  HomeController(this._todoRepo);

  @override
  void onInit() {
    loadTodoList();
    super.onInit();
  }

  var todoList = <ToDoResponse>[].obs;
  var selected = ''.obs;
  var newValue = false.obs;
  var isLoading = false.obs;

  void addItem(ToDoResponse toDo) {
    todoList.add(toDo);
  }

  void deleteItem(ToDoResponse toDo) {
    todoList.remove(toDo);
  }

  Future<void> changeStatusItem() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 300));

    isLoading.value = false;
  }

  Future<List<ToDoResponse>> loadTodoList() async {
    var res = await _todoRepo.getListTodo();
    todoList.value = res;

    return res;
  }
}
