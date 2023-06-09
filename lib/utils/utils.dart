import 'package:flutter_todo/models/models.dart';

List<TodoItem> filterTodos(List<TodoItem> todos, Filter filter) {
  switch (filter) {
    case Filter.done:
      return todos.where((todo) => todo.done).toList();
    case Filter.active:
      return todos.where((todo) => !todo.done).toList();
    default:
      return todos;
  }
}
