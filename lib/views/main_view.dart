import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/todo.item.dart';
import 'package:flutter_application_3/models/todo_list_manager.dart';
import 'package:flutter_application_3/views/components/page_transition_builder.dart';
import 'package:flutter_application_3/views/info_view.dart';
import 'package:flutter_application_3/views/input_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListManager>(
      builder: (context, listManager, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Tehtävälista"),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, pageTransitionBuilder(const InfoView()));
                    },
                    icon: const Icon(Icons.info)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InputView()));
                    },
                    icon: const Icon(Icons.add_alarm))
              ],
            ),
            body: ListView.builder(
                itemCount: listManager.items.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return _buildTodoCard(
                      listManager, listManager.items[index], context);
                }));
      },
    );
  }
}

Center _buildTodoCard(
    TodoListManager manager, TodoItem item, BuildContext context) {
  return Center(
      child: Card(
          child: Column(
    children: <Widget>[
      ListTile(
        trailing: IconButton(
          icon: Icon(
            Icons.done,
            color: item.done ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            manager.toggleDOne(item);
          },
        ),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.title),
              Text(DateFormat("dd.MM.yyyy").format(item.deadline))
            ]),
        subtitle: Text(item.description),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InputView(item: item)),
                );
              },
              child: const Text("Muokkaa")),
          const SizedBox(
            width: 10,
          ),
          TextButton(
              onPressed: () {
                manager.delete(item);
              },
              child: const Text("Poista")),
        ],
      )
    ],
  )));
}
