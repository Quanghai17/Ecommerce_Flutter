import 'package:ecommerce/screens/search/SearchScreen.dart';
import 'package:ecommerce/services/product_services.dart';
import 'package:ecommerce/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:flutter/cupertino.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    ProductService().fetchProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;
    final formatCurrency =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 202, 201, 201),
        appBar: GlobalVariables.getAppBar(
            context: context,
            title: 'Danh sách',
            wantBackNavigation: false,
            onClickSearchNavigateTo: const MySearchScreen()),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .008)
                    .copyWith(right: MediaQuery.of(context).size.height * .015),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 0.5),
                    bottom: BorderSide(color: Colors.grey.shade700, width: 0.4),
                  ),
                ),
                child: products.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        // Thay thế Expanded bằng Padding hoặc SizedBox
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .04,
                        ),
                        child: GridView.builder(
                          shrinkWrap:
                              true, // Thêm shrinkWrap để GridView không chiếm hết chiều cao
                          physics:
                              const NeverScrollableScrollPhysics(), // Loại bỏ scroll của GridView
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.72,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Card(
                                  color:
                                      const Color.fromARGB(255, 254, 252, 255),
                                  elevation: 2.5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                .025,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                .02),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Hành động khi nhấn vào sản phẩm
                                          },
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .11,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            child: Image.network(
                                              '${Constants.uri}/${product.imageUrl}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Số lượng đã bán: ${product.sellNumber}',
                                          style: TextStyle(
                                              color: Colors.blue.shade500,
                                              fontSize: 10),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            formatCurrency.format(
                                                int.parse(product.price)),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton.icon(
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              onPressed: () => {},
                                              icon: const Icon(
                                                CupertinoIcons.heart_solid,
                                                size: 30,
                                                color: Colors.black87,
                                              ),
                                              label: const Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Container(
                                              child: InkWell(
                                                onTap: () => {},
                                                child: const Icon(
                                                  CupertinoIcons
                                                      .cart_badge_plus,
                                                  size: 30,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
