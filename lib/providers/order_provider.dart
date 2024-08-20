import 'package:ecommerce/services/order_services.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/models/order.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService();
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void setOrders(List<Order> orders) {
    _orders = orders;
    notifyListeners();
  }

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}
