import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';

class TodoListView extends StatelessWidget {
  List<TodoItem> todos;
  final ValueChanged<String> deleteItem;
  final ValueChanged<String> toggleItem;

  TodoListView({
    super.key,
    required this.todos,
    required this.deleteItem,
    required this.toggleItem,
  });

  @override
  Widget build(BuildContext context) {
    return todos.isNotEmpty
      ? ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title, style: const TextStyle(fontSize: 20.0)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: todos[index].done,
                  onChanged: (value) {
                    toggleItem(todos[index].id);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteItem(todos[index].id);
                  },
                ),
              ],
            ),
          );
        },
      )
      : const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text('No tasks', style: TextStyle(fontSize: 20.0)),
      );
  }
}
