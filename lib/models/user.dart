import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? token; // Optional, chỉ cần khi lưu token sau khi đăng nhập

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
    this.token, // Optional, chỉ cần khi lưu token sau khi đăng nhập
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'password': password,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      password: map['password'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      token: map['token'], // Optional, chỉ cần khi lưu token sau khi đăng nhập
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
