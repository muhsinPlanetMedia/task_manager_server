// lib/models/task.dart
class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String description;
  bool isCompleted;

  // Convert Task to Map for JSON response
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  // Create Task from JSON (for request body)
  factory Task.fromMap(map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }
}
