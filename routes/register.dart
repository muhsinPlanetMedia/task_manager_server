// routes/register.dart
import 'package:dart_frog/dart_frog.dart';
import 'package:task_manager/models/user.dart';
import 'package:task_manager/services/authenticator.dart';



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

    // Check if user already exists
    if (authenticator.userExists(username)) {
      return Response.json(
        statusCode: 409,
        body: {'error': 'User already exists'},
      );
    }

    // Register new user
    final User newUser = authenticator.registerUser(username, password);

    return Response.json(
      statusCode: 201,
      body: {
        'message': 'User registered successfully',
        'user': newUser.toMap(),
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: 500,
      body: {'error': 'Internal Server Error', 'details': e.toString()},
    );
  }
}
