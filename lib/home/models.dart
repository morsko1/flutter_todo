import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class TodoItem {
  String title;
  bool done = false;
  final String id = uuid.v4();

  TodoItem({required this.title});
}

enum Filter { all, active, done }
