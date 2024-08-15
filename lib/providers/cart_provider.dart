import 'package:flutter/material.dart';
import 'package:ecommerce/models/cart.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void setCartItems(List<CartItem> cartItems) {
    _cartItems = cartItems;
    notifyListeners();
  }

  void addCartItem(CartItem cartItem) {
    _cartItems.add(cartItem);
    notifyListeners();
  }

  void removeCartItem(int id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateCartItem(CartItem updatedItem) {
    int index = _cartItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _cartItems[index] = updatedItem;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
