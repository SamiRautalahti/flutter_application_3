import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/todo.item.dart';

class DatabaseHelper {
  static const _databaseName = "todo_database.db";
  static const _databaseVersion = 1;

  static const table = "todos";

  static const columnId = "id";
  static const columnTitle = "title";
  static const columnDescription = "description";
  static const columnDeadline = "deadline";
  static const columnDone = "done";

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    //deleteDatabase(path);

    _db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table(
          $columnId INTEGER PRIMARY KEY,
          $columnTitle TEXT NOT NULL,
          $columnDescription TEXT,
          $columnDeadline INTEGER NOT NULL,
          $columnDone INTEGER NOT NULL
        )''');
  }

  Future<List<TodoItem>> queryAllRows() async {
    final List<Map<String, dynamic>> maps = await _db.query(table);

    return List.generate(maps.length, (index) {
      return TodoItem(
        id: maps[index]['id'],
        title: maps[index]['title'],
        description: maps[index]['description'],
        deadline: DateTime.fromMillisecondsSinceEpoch(maps[index]['deadline']),
        done: maps[index]['done'] == 1,
      );
    });
  }

  Future<int> insert(TodoItem item) async {
    return await _db.insert(table, item.toMap());
  }

  Future<int> delete(int id) async {
    return await _db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(TodoItem item) async {
    log('Update: $item.id');
    int result = await _db.update(table, item.toMap(),
        where: '$columnId = ?', whereArgs: [item.id]);
    return result;
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
