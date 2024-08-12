import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  try {
    switch (response.statusCode) {
      case 200:
        onSuccess();
        break;
      case 400:
        final body = jsonDecode(response.body);
        showSnackBar(context, body['msg'] ?? 'Bad Request');
        break;
      case 500:
        final body = jsonDecode(response.body);
        showSnackBar(context, body['error'] ?? 'Server Error');
        break;
      default:
        showSnackBar(context, 'Unexpected Error: ${response.statusCode}');
    }
  } catch (e) {
    showSnackBar(context, 'Error parsing response: ${e.toString()}');
  }
}
