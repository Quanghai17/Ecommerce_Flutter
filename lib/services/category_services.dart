import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ecommerce/models/category.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryService {
  Future<void> fetchCategories(BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}/api/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        List<Category> categories = (jsonResponse['data'] as List)
            .map((data) => Category.fromMap(data))
            .toList();

        Provider.of<CategoryProvider>(context, listen: false)
            .setCategories(categories);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
