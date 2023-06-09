import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/utils/utils.dart';
import 'package:flutter_todo/widgets/filter_panel.dart';
import 'package:flutter_todo/widgets/todo_list_view.dart';
import 'package:flutter_todo/widgets/new_task_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<TodoItem> todos = [
    TodoItem(title: 'title 1'),
    TodoItem(title: 'title 2'),
    TodoItem(title: 'title 3'),
  ];

  Filter filter = Filter.all;

  void _addItem(String title) {
    setState(() {
      todos.add(TodoItem(title: title));
    });
  }

  void _deleteItem(String id) {
    setState(() {
      todos = todos.where((todo) => todo.id != id).toList();
    });
  }

  void _toggleItem(String id) {
    setState(() {
      TodoItem todo = todos.firstWhere((item) => item.id == id);
      todo.done = !todo.done;
    });
  }

  void _onFilterChange(Filter? value) {
    setState(() {
      filter = value ?? Filter.all;
    });
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return NewTaskDialog(onSubmit: _addItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TodoItem> todosFiltered = filterTodos(todos, filter);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: TodoListView(
              todos: todosFiltered,
              deleteItem: _deleteItem,
              toggleItem: _toggleItem,
            ),
          ),
          FilterPanel(onChanged: _onFilterChange, filter: filter),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
