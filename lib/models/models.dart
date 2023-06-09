import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class TodoItem {
  String id = uuid.v4();
  String title;
  bool done = false;

  TodoItem({required this.title});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }

  TodoItem.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      title = json['title'],
      done = json['done'];
}

enum Filter { all, active, done }
