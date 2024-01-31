class TodoItem {
  int id = 0;
  String title = "";
  String description = "";
  DateTime deadline = DateTime.now();
  bool done = false;
  String? fbid;

  TodoItem(
      {this.id = 0,
      required this.title,
      this.description = "",
      required this.deadline,
      this.done = false});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.millisecondsSinceEpoch,
      'done': done ? 1 : 0,
    };
  }

  TodoItem.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'] as String,
        description = json['description'] as String,
        deadline = DateTime.parse(json['deadline'] as String),
        done = json['done'] as bool;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
        'deadline': deadline.toString(),
        'done': done,
      };
}
