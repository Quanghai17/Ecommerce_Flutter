import 'package:flutter/material.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:ecommerce/utils/global_variables.dart';
import 'package:ecommerce/screens/search/SearchScreen.dart';
import 'package:ecommerce/utils/utils.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');

    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          title: 'Chi tiết sản phẩm',
          wantBackNavigation: true,
          onClickSearchNavigateTo: const MySearchScreen()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05)
              .copyWith(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .3,
                    child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          setState(() {});
                        },
                        itemCount: 1,
                        // physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // print("............index = $index");
                          return Builder(
                            builder: (context) => Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.05),
                              child: Image.network(
                                  '${Constants.uri}/${widget.product.imageUrl}',
                                  fit: BoxFit.contain,
                                  height:
                                      MediaQuery.of(context).size.width * 0.3),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              Text(widget.product.description,
                  style: TextStyle(color: Colors.grey.shade500),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis),
              const Text("Còn hàng", style: TextStyle(color: Colors.teal)),
              SizedBox(height: MediaQuery.of(context).size.width * .025),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(31, 117, 117, 117), width: 1),
                  // color: Color.fromARGB(255, 147, 147, 147),
                ),
                child: Text(
                  formatCurrency.format(int.parse(widget.product.price)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      // color: Colors.,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * .025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * .25,
                            MediaQuery.of(context).size.height * .06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    child: const Text(
                      "Thêm vào giỏ hàng",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * .25,
                            MediaQuery.of(context).size.height * .06),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      "Mua ngay",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
