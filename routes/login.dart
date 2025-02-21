// routes/login.dart
import 'package:dart_frog/dart_frog.dart';
import 'package:task_manager/services/authenticator.dart';
import 'package:task_manager/models/user.dart';



Future<Response> onRequest(RequestContext context) async {
  final Authenticator authenticator = Authenticator.instance;
  try {
    // Parse request body
    final body = await context.request.json() as Map<String, dynamic>;
    final username = body['username'] as String?;
    final password = body['password'] as String?;

    // Validate input
    if (username == null || password == null) {
      return Response.json(
        statusCode: 400,
        body: {'error': 'Username and password are required'},
      );
    }

    // Authenticate user
    final User? user = authenticator.login(username, password);

    if (user != null) {
      return Response.json(
        body: {
          'message': 'Login successful',
          'user': user.toMap(),
        },
      );
    } else {
      return Response.json(
        statusCode: 401,
        body: {'error': 'Invalid username or password'},
      );
    }
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Internal Server Error', 'details': e.toString()},
    );
  }
}
