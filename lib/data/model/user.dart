import 'dart:convert';

User userModelFromJson(String str) => User.fromJson(json.decode(str));

class User {
  String id;
  String name;
  String email;
  String
      password; // Ideally, passwords should not be stored in plaintext like this
  String role;
  int version;
  String token;

  User({
    this.id = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.role = '',
    this.version = 0,
    this.token = '',
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      version: json['__v'] ?? 0,
      token: json['token'] ?? '1123',
    );
  }

  // Method to convert a User to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      '__v': version,
      'token': token,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, role: $role, version: $version, token: $token}';
  }
}
