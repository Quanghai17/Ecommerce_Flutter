import 'package:flutter/material.dart';
import 'package:ecommerce/models/cart.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:ecommerce/services/cart_services.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;

  const CartProduct({
    required this.cartItem,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Định dạng số tiền
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');

    return ListTile(
      leading: cartItem.product?.imageUrl != null
          ? Image.network(
              '${Constants.uri}/${cartItem.product!.imageUrl}',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : const SizedBox.shrink(),
      title: Text(cartItem.product?.name ?? 'Unknown Product'),
      subtitle: Text(cartItem.product?.price != null
          ? formatCurrency.format(double.parse(cartItem.product!.price))
          : '0 VND'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: onDecreaseQuantity,
          ),
          Text('${cartItem.quantity}'),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: onIncreaseQuantity,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
