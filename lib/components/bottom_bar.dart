import 'package:ecommerce/screens/account/account_screen.dart';
import 'package:ecommerce/screens/cart/cart_screen.dart';
import 'package:ecommerce/screens/category/category_grid_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const AccountScreen(),
    const CartScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _page,
        onTap: (i) => setState(() => _page = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Trang Chủ"),
            selectedColor: const Color.fromARGB(255, 7, 7, 7),
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text("Sản phẩm"),
            selectedColor: const Color.fromARGB(255, 8, 8, 8),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Tài khoản"),
            selectedColor: const Color.fromARGB(255, 0, 0, 0),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text("Giỏ hàng"),
            selectedColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
