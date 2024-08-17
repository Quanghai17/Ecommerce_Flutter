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

  double get totalAmount {
    double total = 0.0;
    for (var item in _cartItems) {
      if (item.product != null) {
        total += double.parse(item.product!.price) * item.quantity;
      }
    }
    return total;
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

  void increaseQuantity(CartItem cartItem) {
    cartItem.quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity -= 1;
      notifyListeners();
    }
  }
}
