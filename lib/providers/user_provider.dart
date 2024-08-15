import 'package:ecommerce/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: 0,
    name: '',
    email: '',
    role: '',
    password: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    token: null,
  );

  User get user => _user;

  void setUser(String userJson) {
    _user = User.fromJson(userJson);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = User(
      id: 0,
      name: '',
      email: '',
      role: '',
      password: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      token: null,
    );
    notifyListeners();
  }
}
