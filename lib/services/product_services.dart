import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/providers/product_provider.dart';

class ProductService {
  Future<void> fetchProducts(BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}/api/products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (res.statusCode == 200) {
        final jsonResponse = jsonDecode(res.body);
        List<Product> products = (jsonResponse['data'] as List)
            .map((data) => Product.fromMap(data))
            .toList();
        Provider.of<ProductProvider>(context, listen: false)
            .setProducts(products);
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
