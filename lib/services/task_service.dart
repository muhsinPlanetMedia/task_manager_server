import 'dart:convert';
import 'dart:io';
import 'package:task_manager/models/task.dart';

class TaskService {
  static final TaskService instance = TaskService._internal();
  final List<Task> _tasks = [];
  File? _file;

  TaskService._internal();

  Future<void> _initFile() async {
    final directory = Directory.current;
    _file = File('${directory.path}/tasks.json');

    if (!(await _file!.exists())) {
      await _file!.create();
      await _file!.writeAsString(jsonEncode([]));
    }
  }

  Future<void> _loadTasks() async {
    if (_file == null) await _initFile();
    final content = await _file!.readAsString();
    final  decoded = jsonDecode(content) as List;
    _tasks.clear();
    _tasks.addAll(decoded.map((task) => Task.fromMap(task)));
  }

  Future<void> _saveTasks() async {
    if (_file == null) await _initFile();
    await _file!.writeAsString(jsonEncode(_tasks.map((task) => task.toMap()).toList()));
  }

  Future<Task> createTask(String title, String description) async {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isCompleted: false,
    );
    _tasks.add(task);
    await _saveTasks();
    return task;
  }

  Future<List<Task>> getAllTasks() async {
    await _loadTasks();
    return _tasks;
  }

  Future<Task?> updateTask(String id, {String? title, String? description, bool? isCompleted}) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex == -1) {
      return null;
    }
    final task = _tasks[taskIndex];
    _tasks[taskIndex] = Task(
      id: task.id,
      title: title ?? task.title,
      description: description ?? task.description,
      isCompleted: isCompleted ?? task.isCompleted,
    );
    await _saveTasks();
    return _tasks[taskIndex];
  }
}