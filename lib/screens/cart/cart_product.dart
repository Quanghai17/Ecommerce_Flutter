import 'package:flutter/material.dart';

import 'package:ecommerce/models/cart.dart';

import 'package:ecommerce/utils/constants.dart';

import 'package:intl/intl.dart';

import 'package:ecommerce/services/cart_services.dart';

import 'package:provider/provider.dart';


class CartProduct extends StatefulWidget {

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

  _CartProductState createState() => _CartProductState();

}


class _CartProductState extends State<CartProduct> {

  final CartService cartService = CartService();


  @override

  Widget build(BuildContext context) {

    // Định dạng số tiền

    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');


    return ListTile(

      leading: widget.cartItem.product?.imageUrl != null

          ? Image.network(

              '${Constants.uri}/${widget.cartItem.product!.imageUrl}',

              width: 50,

              height: 50,

              fit: BoxFit.cover,

            )

          : const SizedBox.shrink(),

      title: Text(widget.cartItem.product?.name ?? 'Unknown Product'),

      subtitle: Text(widget.cartItem.product?.price != null

          ? formatCurrency.format(double.parse(widget.cartItem.product!.price))

          : '0 VND'),

      trailing: Row(

        mainAxisSize: MainAxisSize.min,

        children: [

          IconButton(

            icon: const Icon(Icons.remove_circle_outline),

            onPressed: () async {

              if (widget.cartItem.quantity > 1) {

                await cartService.updateCartItemQuantity(context,
                    widget.cartItem.productId, widget.cartItem.quantity - 1);

                widget.onDecreaseQuantity();

                setState(() {}); // Cập nhật giao diện sau khi giảm số lượng

              }

            },

          ),

          Text('${widget.cartItem.quantity}'),

          IconButton(

            icon: const Icon(Icons.add_circle_outline),

            onPressed: () async {

              await cartService.updateCartItemQuantity(context,
                  widget.cartItem.productId, widget.cartItem.quantity + 1);

              widget.onIncreaseQuantity();

              setState(() {}); // Cập nhật giao diện sau khi tăng số lượng

            },

          ),

          IconButton(

            icon: const Icon(Icons.delete_forever),

            onPressed: () async {

              await cartService.removeCartItem(context, widget.cartItem.id);

              // Có thể cần thêm logic để xóa sản phẩm khỏi giỏ hàng và cập nhật giao diện

            },

          ),

        ],

      ),

    );

  }

}

