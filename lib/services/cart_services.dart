import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/utils/utils.dart';

class CartService {
  Future<void> addToCart(BuildContext context, int productId) async {
    try {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      http.Response response = await http.post(
        Uri.parse('${Constants.uri}/api/addToCart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'productId': productId,
        }),
      );

      final Map<String, dynamic> resData = jsonDecode(response.body);

      if (resData['success']) {
        CartItem newCartItem = CartItem.fromJson(resData['data']);
        cartProvider.addCartItem(newCartItem);
        showSnackBar(context, 'Sản phẩm đã được thêm vào giỏ hàng');
      } else {
        showSnackBar(
            context, resData['message'] ?? 'Failed to add product to cart');
      }
    } catch (e) {
      if (ScaffoldMessenger.maybeOf(context) != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')),
        );
      }
      print(e);
    }
  }

  Future<void> fetchCartItems(BuildContext context) async {
    try {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      http.Response response = await http.get(
        Uri.parse('${Constants.uri}/api/getProductCart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
      );

      final Map<String, dynamic> resData = jsonDecode(response.body);

      if (resData['success']) {
        List<CartItem> cartItems = (resData['data'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
        cartProvider.setCartItems(cartItems);
      } else {
        showSnackBar(
            context, resData['message'] ?? 'Failed to fetch cart items');
      }
    } catch (e) {
      if (ScaffoldMessenger.maybeOf(context) != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${e.toString()}')),
        );
      }
      print(e);
    }
  }
}
