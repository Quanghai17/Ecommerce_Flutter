import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  void addProdut(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
