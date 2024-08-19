import 'package:ecommerce/components/custom_button.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/screens/cart/cart_product.dart';
import 'package:ecommerce/screens/cart/cart_subtotal.dart';
import 'package:ecommerce/screens/category/category_grid_screen.dart';
import 'package:ecommerce/screens/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/screens/search/SearchScreen.dart';
import 'package:ecommerce/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/services/cart_services.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService cartService = CartService();

  @override
  void initState() {
    super.initState();
    cartService.fetchCartItems(context);
  }

  @override
  Widget build(BuildContext context) {
    // Lấy cartProvider từ Provider
    final cartProvider = Provider.of<CartProvider>(context).cartItems;

    return Scaffold(
      appBar: GlobalVariables.getAppBar(
        context: context,
        title: 'Giỏ hàng',
        wantBackNavigation: false,
        onClickSearchNavigateTo: const MySearchScreen(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            const Subtotal(),
            Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .05),
                child: cartProvider.isEmpty
                    ? TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CategoryScreen(),
                            ),
                          );
                        },
                        child: const Text('Mua hàng ngay'),
                      )
                    : CustomButton(
                        text: "Thanh toán",
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutScreen(),
                            ),
                          )
                        },
                        color: Colors.yellow[500],
                      )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(color: Colors.black12.withOpacity(0.08), height: 1),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: cartProvider.isEmpty
                  ? Column(
                      children: [
                        Image.asset(
                          "assets/images/no-orderss.png",
                          height: MediaQuery.of(context).size.height * .15,
                        ),
                        const Text("No item in cart"),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: cartProvider.length,
                      itemBuilder: (context, index) {
                        // Hiển thị từng sản phẩm trong giỏ hàng
                        final cartItem = cartProvider[index];
                        return CartProduct(
                          cartItem: cartItem,
                          onIncreaseQuantity: () {},
                          onDecreaseQuantity: () {},
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
