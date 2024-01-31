import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_3/models/todo.item.dart';

class FirebaseHelper {
  final DatabaseReference _todoItemsRef =
      FirebaseDatabase.instance.ref().child('todo_items');

  void saveTodoItem(TodoItem item) {
    _todoItemsRef.push().set(item.toJson());
  }

  Future<List<TodoItem>> getData() async {
    List<TodoItem> items = [];

    DatabaseEvent event = await _todoItemsRef.once();

    var snapshot = event.snapshot;
    for (var child in snapshot.children) {
      TodoItem item = TodoItem.fromJson(child.value as Map<dynamic, dynamic>);
      item.fbid = child.key;
      items.add(item);
    }
    return items;
  }
}
