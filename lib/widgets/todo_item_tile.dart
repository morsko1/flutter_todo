import 'package:flutter/material.dart';

class TodoItemTile extends StatelessWidget {
  final String title;
  final bool done;
  final VoidCallback onDelete;
  final ValueChanged<bool?> onToggle;

  const TodoItemTile({
    super.key,
    required this.title,
    required this.done,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: done,
            onChanged: onToggle,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
