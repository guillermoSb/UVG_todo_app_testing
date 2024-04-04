mixin TodoFormValidators {
  bool canSubmitTodo(String todo) {
    return todo.isNotEmpty;
  }

  String? todoErrorText(String todo) {
    final showError = !canSubmitTodo(todo);
    final errorMessage = todo.isEmpty ? 'Todo cannot be empty' : 'Invalid Todo';
    return showError ? errorMessage : null;
  }
}
