import 'dart:convert';
import 'package:ecommerce/components/bottom_bar.dart';
import 'package:ecommerce/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/utils/utils.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/providers/user_provider.dart';

class AuthService {
  // Đăng ký người dùng
  void signUpUser({
    required BuildContext context,
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      final User user = User(
        id: 0,
        name: name,
        email: email,
        role: 'USER', // Hoặc giá trị role mặc định khác
        password: password,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        token: null, // Chưa có token khi đăng ký
      );

      final navigator = Navigator.of(context);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, 'An error occurred: $e');
    }
  }

  // Đăng nhập người dùng
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // Lấy userProvider trước khi thực hiện các hành động bất đồng bộ
      var userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // Trích xuất token từ phản hồi
        final responseData = jsonDecode(res.body);
        final String token = responseData['data'];

        // Lưu token vào SharedPreferences
        await prefs.setString('x-auth-token', token);

        // Cập nhật token trong UserProvider mà không sử dụng BuildContext
        userProvider.setUserFromModel(
          User(
            id: 0,
            name: '',
            email: '',
            token: token,
            password: '',
            role: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

        // Điều hướng đến BottomBar
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar()),
            (route) => false,
          );
        }
      } else {
        showSnackBar(context, 'Failed to sign in.');
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, 'An error occurred: ${e.toString()}');
      }
    }
  }

  // Lấy dữ liệu người dùng
  Future<void> getUserData(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      http.Response userRes = await http.get(
        Uri.parse('${Constants.uri}/api/userDetail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> resData = jsonDecode(userRes.body);
      if (resData['success']) {
        User user = User.fromMap(resData['data']);
        userProvider.setUserFromModel(user);
      } else {
        showSnackBar(context, 'Failed to retrieve user data');
      }
    } catch (e) {
      if (ScaffoldMessenger.maybeOf(context) != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')),
        );
      }
    }
  }

  // Đăng xuất người dùng
  void signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('x-auth-token');
    Provider.of<UserProvider>(context, listen: false).clearUser();
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}
