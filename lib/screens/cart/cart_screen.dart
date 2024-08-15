import 'package:ecommerce/components/custom_button.dart';
import 'package:ecommerce/screens/cart/cart_subtotal.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/screens/search/SearchScreen.dart';
import 'package:ecommerce/utils/global_variables.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GlobalVariables.getAppBar(
            context: context,
            title: 'Giỏ hàng',
            wantBackNavigation: false,
            onClickSearchNavigateTo: const MySearchScreen()),
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
                child: CustomButton(
                    text: "Thanh toán",
                    onTap: () => {},
                    color: Colors.yellow[500]),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(color: Colors.black12.withOpacity(0.08), height: 1),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ));
  }
}
