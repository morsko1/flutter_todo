import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';

class FilterPanel extends StatelessWidget {
  final ValueChanged<Filter?> onChanged;
  Filter filter;

  FilterPanel({
    super.key,
    required this.onChanged,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RadioListTile(
          title: const Text('all'),
          value: Filter.all,
          groupValue: filter,
          onChanged: onChanged,
          selected: filter == Filter.all,
          selectedTileColor: Colors.lightBlueAccent,
        ),
        RadioListTile(
          title: const Text('active'),
          value: Filter.active,
          groupValue: filter,
          onChanged: onChanged,
          selected: filter == Filter.active,
          selectedTileColor: Colors.lightBlueAccent,
        ),
        RadioListTile(
          title: const Text('done'),
          value: Filter.done,
          groupValue: filter,
          onChanged: onChanged,
          selected: filter == Filter.done,
          selectedTileColor: Colors.lightBlueAccent,
        ),
      ],
    );
  }
}
