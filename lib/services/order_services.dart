import 'dart:convert';
import 'package:ecommerce/components/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/providers/order_provider.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/utils/utils.dart';

class OrderService {
  Future<void> createOrder(BuildContext context, List<OrderItem> items,
      String shippingAddress, String name, String email, String phone) async {
    try {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null || token.isEmpty) {
        throw Exception('Token is null or empty');
      }

      http.Response response = await http.post(
        Uri.parse('${Constants.uri}/api/createOrder'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'items': items.map((item) => item.toJson()).toList(),
          'shippingAddress': shippingAddress,
          'name': name,
          'email': email,
          'phone': phone,
        }),
      );

      final Map<String, dynamic> resData = jsonDecode(response.body);

      if (resData['success']) {
        Order newOrder = Order.fromJson(resData['data']);
        orderProvider.addOrder(newOrder);
        showSnackBar(context, 'Thanh toán thành công');

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar()),
            (route) => false,
          );
        }
      } else {
        showSnackBar(context, resData['message'] ?? 'Failed to create order');
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
