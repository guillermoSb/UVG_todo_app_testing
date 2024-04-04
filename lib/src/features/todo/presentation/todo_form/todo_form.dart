import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/constants/app_sizes.dart';
import 'package:todo_app/src/features/todo/presentation/todo_form/todo_form_controller.dart';
import 'package:todo_app/src/features/todo/presentation/todo_form/todo_form_validators.dart';

/// Form to create a new todo.
class TodoForm extends ConsumerStatefulWidget {
  const TodoForm({super.key});

  @override
  ConsumerState<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends ConsumerState<TodoForm> with TodoFormValidators {
  final _formKey = GlobalKey<FormState>();
  final _todo = TextEditingController();
  var _submitted = false;
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoFormControllerProvider);
    ref.listen(todoFormControllerProvider, (prev, current) {
      if (prev != null) {
        if (prev.isLoading && current.hasValue && !current.isLoading) {
          Navigator.of(context).pop();
        }
      }
    });
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text('Create Todo'),
            gapH16,
            TextFormField(
              key: const Key('todo_text_field'),
              controller: _todo,
              onChanged: (value) => _todo.text = value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                hintText: 'Buy coffee...',
                labelText: 'Todo',
              ),
              validator: (value) =>
                  _submitted ? todoErrorText(value ?? '') : null,
            ),
            gapH12,
            if (state.isLoading) const CircularProgressIndicator(),
            if (!state.isLoading)
              ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        setState(() => _submitted = true);
                        if (_formKey.currentState?.validate() == false) return;
                        final controller =
                            ref.read(todoFormControllerProvider.notifier);
                        controller.addTodo(_todo.text);
                      },
                child: const Text('Save'),
              ),
          ],
        ),
      ),
    );
  }
}
