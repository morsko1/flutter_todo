import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
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
      for (var todo in todos) {
        if (todo.id == id) {
          todo.done = !todo.done;
          break;
        }
      }
    });
  }

  void _onFilterChange(Filter? value) {
    setState(() {
      filter = value ?? Filter.all;
    });
  }

  // TODO: move text controller to dialog
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _dialogBuilder(BuildContext context) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return NewTaskDialog(
          textFieldController: _textFieldController,
          onSubmit: _addItem,
        );
      },
    ).then((value) {
      _textFieldController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TodoItem> todosFiltered;
    switch (filter) {
      case Filter.done:
        todosFiltered = todos.where((todo) => todo.done).toList();
        break;
      case Filter.active:
        todosFiltered = todos.where((todo) => !todo.done).toList();
        break;
      default:
        todosFiltered = todos;
    }

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
