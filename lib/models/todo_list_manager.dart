import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/todo.item.dart';
import '../data/firebase_helper.dart';
import '../globals.dart';

class TodoListManager extends ChangeNotifier {
  final List<TodoItem> _items = [];
  final fbHelper = FirebaseHelper();

  TodoListManager() {
    /*_items.add(TodoItem(
      title: "Tehtävä",
      deadline: DateTime.parse("2024-02-01"),
      description: "Tehtävän kuvaus",
      done: true,
    ));
    _items.add(TodoItem(
      title: "Tehtävä",
      deadline: DateTime.parse("2024-02-01"),
      description: "Tehtävän kuvaus",
      done: true,
    ));
    _items.add(TodoItem(
      title: "Tehtävä",
      deadline: DateTime.parse("2024-02-01"),
      description: "Tehtävän kuvaus",
      done: false,
    ));
    _items.add(TodoItem(
      title: "Tehtävä",
      deadline: DateTime.parse("2024-02-01"),
      description: "Tehtävän kuvaus",
      done: false,
    ));*/
  }
  Future<void> init() async {
    //loadFromDB();
    loadFromFirebase();
  }

  UnmodifiableListView<TodoItem> get items => UnmodifiableListView(_items);

  Future<void> add(TodoItem item) async {
    log("Lisätään item");
    //item.id = await dbHelper.insert(item);
    item.created = DateTime.now();
    item.updated = DateTime.now();
    fbHelper.saveTodoItem(item);
    _items.add(item);

    notifyListeners();
  }

  void delete(TodoItem item) {
    log("Poistetaan item");
    //dbHelper.delete(item.id);
    fbHelper.deleteTodoItem(item);
    _items.remove(item);

    notifyListeners();
  }

  void update(TodoItem item) {
    TodoItem? oldItem;
    for (TodoItem i in _items) {
      if (i.id == item.id) {
        oldItem = i;
        break;
      }
    }
    if (oldItem != null) {
      oldItem.title = item.title;
      oldItem.description = item.description;
      oldItem.deadline = item.deadline;
      oldItem.done = item.done;
      oldItem.updated = DateTime.now();

      //dbHelper.update(item);
      fbHelper.updateTodoItem(item);
      notifyListeners();
    }
  }

  void toggleDOne(TodoItem item) {
    if (item.done) {
      log("Muutetaan tekemättömäksi");
    } else {
      log("Muutetaan tehdyksi");
    }
    item.done ? item.done = false : item.done = true;

    notifyListeners();
  }

  void loadFromDB() async {
    final list = await dbHelper.queryAllRows();
    for (TodoItem item in list) {
      _items.add(item);
    }
    notifyListeners();
  }

  void loadFromFirebase() async {
    final list = await fbHelper.getData();
    int id = 1;
    for (TodoItem item in list) {
      item.id = id;
      _items.add(item);
      id++;
    }
    notifyListeners();
  }
}
