import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todoapp/feature/home/home_binding.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/widget/todo_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _homeController = Get.find();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Todo App'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _homeController.isLoading.value == true
                    ? const CircularProgressIndicator(
                        color: Colors.amber,
                      )
                    : Obx(
                        () => Expanded(
                          child: ListView.builder(
                              itemCount: _homeController.todoList.length,
                              itemBuilder: (context, index) {
                                var data = _homeController.todoList;

                                return ToDoItem(
                                  todo: ToDoResponse(
                                      id: data[index].id,
                                      todoName: data[index].todoName,
                                      isDone: data[index].isDone),
                                  onToDoChanged: () {
                                    data[index].isDone = !data[index].isDone;
                                    _homeController.changeStatusItem();
                                  },
                                  onDeleteItem: () {
                                    _homeController.deleteItem(data[index]);
                                  },
                                );
                              }),
                        ),
                      ),
                Container(
                  margin: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                  padding: const EdgeInsets.only(
                      left: 10, top: 8, right: 8, bottom: 8),
                  height: 56,
                  width: double.infinity,
                  // decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Input Name Todo",
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            _homeController.addItem(ToDoResponse(
                                id: _homeController.todoList.last.id! + 1,
                                todoName: _controller.text));
                            _controller.clear();
                          } else {
                            Get.snackbar('Warning!', 'Please input name todo');
                          }
                        },
                        elevation: 0,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
