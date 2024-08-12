import 'dart:convert';

import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/models/user.dart';
import 'package:ecommerce/utils/utils.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/providers/user_provider.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String name,
      required String password,
      required String email}) async {
    try {
      User user =
          User(id: '', name: name, email: email, token: '', password: password);

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
          showSnackBar(
            context,
            'Đăng kí thành công!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }

  void signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);

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

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // Trích xuất token từ phản hồi
          final responseData = jsonDecode(res.body);
          final String token = responseData['data'];

          // Gán giá trị token vào userProvider
          userProvider.setUser(jsonEncode({
            'email': email,
            'token': token,
          }));

          await prefs.setString('x-auth-token', token);

          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }

  void getUserData(BuildContext context) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null || token.isEmpty) {
        prefs.setString('x-auth-token', '');
        return; // If there's no token, return early.
      }

      http.Response userRes = await http.get(
        Uri.parse('${Constants.uri}/api/userDetail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
      );

      if (userRes.statusCode == 200) {
        final Map<String, dynamic> resData = jsonDecode(userRes.body);
        if (resData['success'] == true) {
          userProvider.setUser(jsonEncode(resData['data']));
        } else {
          showSnackBar(context, resData['message']);
        }
      } else {
        showSnackBar(context, 'Failed to fetch user data.');
      }
    } catch (e) {
      showSnackBar(context, 'An error occurred: ${e.toString()}');
    }
  }
}
