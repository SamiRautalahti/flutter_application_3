import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_3/models/todo.item.dart';

class FirebaseHelper {
  final DatabaseReference _todoItemsRef = FirebaseDatabase.instance
      .ref()
      .child('todo_items')
      .child(FirebaseAuth.instance.currentUser!.uid);

  void saveTodoItem(TodoItem item) {
    var itemRef = _todoItemsRef.push();
    item.fbid = itemRef.key;
    item.owner = FirebaseAuth.instance.currentUser!.uid;
    itemRef.set(item.toJson());
  }

  void deleteTodoItem(TodoItem item) {
    if (item.fbid != null) {
      _todoItemsRef.child(item.fbid.toString()).remove();
    }
  }

  void updateTodoItem(TodoItem item) {
    if (item.fbid != null) {
      _todoItemsRef.child(item.fbid.toString()).update(item.toJson());
    }
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
