// lib/models/user.dart
class User {
  const User({
    required this.id,
    required this.username,
    required this.password,
  });

  final String id;
  final String username;
  final String password;

  // Convert User object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  // Create a User object from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }
}
