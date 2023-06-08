import 'package:flutter/material.dart';
import 'package:flutter_todo/home/models.dart';
import 'package:flutter_todo/home/todo_item_tile.dart';

class TodoListView extends StatelessWidget {
  List<TodoItem> todos;
  // final VoidCallback<String> deleteItem;
  // VoidCallback<String> deleteItem;
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
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoItemTile(
          title: todos[index].title,
          done: todos[index].done,
          onDelete: () {
            deleteItem(todos[index].id);
          },
          onToggle: (value) {
            toggleItem(todos[index].id);
          },
        );
      },
    );
  }
}