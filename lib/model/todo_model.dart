class ToDoResponse {
  int? id;
  String? todoName;
  bool isDone;

  ToDoResponse({
    required this.id,
    required this.todoName,
    this.isDone = false,
  });
  factory ToDoResponse.fromJson(Map<String, dynamic> json) => ToDoResponse(
      id: json["id"] ?? '',
      todoName: json["todoName"] ?? '',
      isDone: json["isDone"] ?? '');

  Map<String, dynamic> toJson() => {
        "id": id,
        "todoName": todoName,
        "isDone": isDone,
      };
}
