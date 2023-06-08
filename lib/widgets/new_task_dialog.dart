import 'package:flutter/material.dart';

class NewTaskDialog extends StatelessWidget {
  final ValueChanged<String> onSubmit;
  final TextEditingController _textFieldController;

  const NewTaskDialog({
    super.key,
    required TextEditingController textFieldController,
    required this.onSubmit,
  }) : _textFieldController = textFieldController;

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
          child: const Text('Ok'),
          onPressed: () {
            String inputValue = _textFieldController.text;
            if (inputValue.isEmpty) {
              Navigator.of(context).pop();
              return;
            }
            onSubmit(inputValue);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
