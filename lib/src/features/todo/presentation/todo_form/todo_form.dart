import 'package:flutter/material.dart';
import 'package:todo_app/src/constants/app_sizes.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text('Create Todo'),
          gapH16,
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter your todo',
            ),
          ),
          gapH12,
          // Date Picker Dialog
          TextButton(
            child: const Text('Select Date'),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
            },
          ),

          gapH12,
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
