// lib/services/task_service.dart
import 'package:task_manager/models/task.dart';

class TaskService {
  static final TaskService instance = TaskService._internal();
  final List<Task> _tasks = [];

  TaskService._internal();

  // Add a new task
  Task createTask(String title, String description) {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isCompleted: false,
    );

    _tasks.add(task);
    return task;
  }

  // Get all tasks
  List<Task> getAllTasks() {
    return _tasks;
  }

  // Update a task
  Task? updateTask(String id, {String? title, String? description, bool? isCompleted}) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex == -1) {
      return null; // Task not found
    }

    final task = _tasks[taskIndex];

    _tasks[taskIndex] = Task(
      id: task.id,
      title: title ?? task.title,
      description: description ?? task.description,
      isCompleted: isCompleted ?? task.isCompleted,
    );

    return _tasks[taskIndex];
  }
}
