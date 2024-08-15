import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';

class Subtotal extends StatelessWidget {
  const Subtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');

    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
      child: Row(
        children: [
          const Text(
            "Tổng tiền ",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            formatCurrency.format(
                cartProvider.totalAmount), // Chuyển đổi double thành chuỗi
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
