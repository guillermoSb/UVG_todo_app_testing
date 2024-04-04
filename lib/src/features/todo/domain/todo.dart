// coverage:ignore-file
typedef TodoId = String;

/// Domain representation of a Todo
class Todo {
  final TodoId? id;
  final String title;
  final bool completed;

  const Todo({
    this.id,
    required this.title,
    this.completed = false,
  });

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, completed: $completed, )';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ completed.hashCode;
  }

  Todo copyWith({
    TodoId? id,
    String? title,
    bool? completed,
    DateTime? dueDate,
  }) {
    return Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed);
  }
}
