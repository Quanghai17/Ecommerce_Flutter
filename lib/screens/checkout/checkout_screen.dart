import 'package:ecommerce/components/custom_button.dart';
import 'package:ecommerce/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/global_variables.dart';
import 'package:ecommerce/screens/search/SearchScreen.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/user_provider.dart';
import 'package:ecommerce/services/order_services.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:ecommerce/models/order.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController shippingAddressController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final OrderService orderService = OrderService();

  @override
  void dispose() {
    shippingAddressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void handlePayment() async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final name = userProvider.user.name ?? 'Unknown';
    final email = userProvider.user.email ?? 'Unknown';

    await orderService.createOrder(
      context,
      cartProvider.cartItems.map((item) {
        return OrderItem(
          productId: item.product?.id ?? 0,
          quantity: item.quantity,
          price: int.parse(item.product?.price ?? '0'),
        );
      }).toList(),
      shippingAddressController.text,
      name,
      email,
      phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context).cartItems;
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');

    return Scaffold(
      appBar: GlobalVariables.getAppBar(
        context: context,
        title: 'Thanh toán',
        wantBackNavigation: true,
        onClickSearchNavigateTo: const MySearchScreen(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text("Danh sách đơn hàng",
                    style: TextStyle(fontSize: 15)),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
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
                          final cartItem = cartProvider[index];
                          return ListTile(
                            leading: cartItem.product?.imageUrl != null
                                ? Image.network(
                                    '${Constants.uri}/${cartItem.product!.imageUrl}',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox.shrink(),
                            title: Text(
                                cartItem.product?.name ?? 'Unknown Product'),
                            subtitle: Text(cartItem.product?.price != null
                                ? formatCurrency.format(
                                    double.parse(cartItem.product!.price))
                                : '0 VND'),
                            trailing: Text(
                              'x ${cartItem.quantity}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Form(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: shippingAddressController,
                      hintText: "Địa chỉ giao hàng",
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    CustomTextField(
                      controller: phoneController,
                      hintText: "Số điện thoại",
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              CustomButton(
                text: "Thanh toán",
                onTap: handlePayment,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
