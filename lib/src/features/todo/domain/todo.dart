// ignore_for_file: public_member_api_docs, sort_constructors_first
typedef TodoId = String;

/// Domain representation of a Todo
class Todo {
  final TodoId id;
  final String title;
  final bool completed;
  final DateTime? dueDate;

  const Todo({
    required this.id,
    required this.title,
    required this.completed,
    this.dueDate,
  });

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, completed: $completed, dueDate: $dueDate)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.completed == completed &&
        other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ completed.hashCode ^ dueDate.hashCode;
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
      completed: completed ?? this.completed,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
