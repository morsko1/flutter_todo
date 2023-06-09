import 'package:flutter/material.dart';

class NewTaskDialog extends StatefulWidget {
  final ValueChanged<String> onSubmit;

  const NewTaskDialog({
    super.key,
    required this.onSubmit,
  });

  @override
  State<NewTaskDialog> createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new task'),
      content: Column(
        children: [
          TextFormField(
            autofocus: true,
            controller: _textFieldController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Ok'),
          onPressed: () {
            String inputValue = _textFieldController.text;
            if (inputValue.isEmpty) {
              Navigator.of(context).pop();
              return;
            }
            widget.onSubmit(inputValue);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
