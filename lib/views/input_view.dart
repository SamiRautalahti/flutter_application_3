import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/todo.item.dart';
import 'package:flutter_application_3/models/todo_list_manager.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InputView extends StatelessWidget {
  final TodoItem? item;
  const InputView({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Lisää uusi tehtävä")),
        body: InputForm(item));
  }
}

// Create a Form widget.
class InputForm extends StatefulWidget {
  final TodoItem? item;
  const InputForm(this.item, {super.key});

  @override
  InputFormState createState() {
    return InputFormState(item);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class InputFormState extends State<InputForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  bool done = false;
  DateTime deadline = DateTime.now();
  TodoItem? item;
  bool isEdit = false;
  int id = 0;

  InputFormState(TodoItem? item) {
    if (item != null) {
      title = item.title;
      description = item.description;
      done = item.done;
      deadline = item.deadline;
      isEdit = true;
      id = item.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                hintText: 'Tehtävän nimi',
                labelText: 'Nimi',
              ),
              onChanged: (value) {
                title = value;
              },
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Anna tehtävälle nimi';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: description,
              decoration: const InputDecoration(
                hintText: 'Tehtävän kuvaus',
                labelText: 'Kuvaus',
              ),
              onChanged: (value) {
                description = value;
              },
              minLines: 5,
              maxLines: 10,
            ),
            _FormDatePicker(
                date: deadline,
                onChanged: (value) {
                  setState(() {
                    deadline = value;
                  });
                }),
            Row(
              children: [
                Checkbox(
                    value: done,
                    onChanged: (value) {
                      setState(() {
                        done = value!;
                      });
                    }),
                const Text("Valmis"),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tallennetaan...')),
                    );
                    TodoItem newItem = TodoItem(
                        title: title,
                        description: description,
                        deadline: deadline,
                        done: done);
                    // Tallennetaan uusi item
                    if (!isEdit) {
                      Provider.of<TodoListManager>(context, listen: false)
                          .add(newItem);
                    } else {
                      newItem.id = id;
                      Provider.of<TodoListManager>(context, listen: false)
                          .update(newItem);
                    }

                    Navigator.pop(context);
                  }
                },
                child: isEdit ? const Text('Muokkaa') : const Text('Lisää'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  final formatter = DateFormat('d.M.yyyy');
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              formatter.format(widget.date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
