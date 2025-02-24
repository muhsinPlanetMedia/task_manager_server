import 'package:dart_frog/dart_frog.dart';
import 'package:task_manager/services/task_service.dart';

final TaskService taskService = TaskService.instance;

Future<Response> onRequest(RequestContext context) async {
  try {
    if (context.request.method == HttpMethod.post) {
      return await _createTask(context);
    } else if (context.request.method == HttpMethod.put) {
      return _updateTask(context);
    } else {
      return Response.json(
        statusCode: 405,
        body: {'error': 'Method Not Allowed'},
      );
    }
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Internal Server Error', 'details': e.toString()},
    );
  }
}


Future<Response> _createTask(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final title = body['title'] as String?;
  final description = body['description'] as String?;

  if (title == null || title.isEmpty || description == null || description.isEmpty) {
    return Response.json(
      statusCode: 400,
      body: {'error': 'Title and description are required'},
    );
  }

  final task =await taskService.createTask(title, description);

  return Response.json(
    statusCode: 201,
    body: {
      'message': 'Task created successfully',
      'task': task.toMap(),
    },
  );
}
// Update a task
Future<Response> _updateTask(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final id = body['id'] as String?;
  final title = body['title'] as String?;
  final description = body['description'] as String?;
  final isCompleted = body['isCompleted'] as bool?;

  if (id == null) {
    return Response.json(
      statusCode: 400,
      body: {'error': 'Task ID is required'},
    );
  }

  final updatedTask =await taskService.updateTask(id, title: title, description: description, isCompleted: isCompleted);

  if (updatedTask == null) {
    return Response.json(
      statusCode: 404,
      body: {'error': 'Task not found'},
    );
  }

  return Response.json(
    statusCode: 200,
    body: {
      'message': 'Task updated successfully',
      'task': updatedTask.toMap(),
    },
  );
}
