import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
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
  List<TodoItem> todos = [];
  Filter filter = Filter.all;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString('todos');
    if (storedData != null) {
      Iterable decoded = jsonDecode(storedData);
      List<TodoItem> todosDecoded = decoded.map((item) => TodoItem.fromJson(item)).toList();
      setState(() {
        todos = todosDecoded;
      });
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encoded = jsonEncode(todos);
    await prefs.setString('todos', encoded);
  }

  void _addItem(String title) {
    setState(() {
      todos.add(TodoItem(title: title));
      _saveData();
    });
  }

  void _deleteItem(String id) {
    setState(() {
      todos = todos.where((todo) => todo.id != id).toList();
      _saveData();
    });
  }

  void _toggleItem(String id) {
    setState(() {
      TodoItem todo = todos.firstWhere((item) => item.id == id);
      todo.done = !todo.done;
      _saveData();
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
