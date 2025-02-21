import 'package:task_manager/models/user.dart';
final Map<String, User> users = {};
class Authenticator {
  static Authenticator get instance=>Authenticator();

  bool userExists(String username) => users.containsKey(username);

  User registerUser(String username, String password) {
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: username,
      password: password,
    );

    users[username] = user;
    return user;
  }

  User? findByUsernameAndPassword({
    required String username,
    required String password,
  }) {
    final user = users[username];
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }

  User? login(String username, String password) {
    final user = findByUsernameAndPassword(username: username, password: password);
    if (user != null) {
      print('Login successful for user: $username');
      return user;
    } else {
      print('Login failed for user: $username');
      return null;
    }
  }
}
