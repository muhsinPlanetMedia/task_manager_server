import 'package:dart_frog/dart_frog.dart';
import 'package:task_manager/services/task_service.dart';
final TaskService taskService = TaskService.instance;

Future<Response> onRequest(RequestContext context) async {
  try {
   if (context.request.method == HttpMethod.get) {
      return _getAllTasks();
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
Response _getAllTasks() {
  final tasks = taskService.getAllTasks();
  return Response.json(
    statusCode: 200,
    body: {'tasks': tasks.map((task) => task.toMap()).toList()},
  );
}
