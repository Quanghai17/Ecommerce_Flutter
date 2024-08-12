import 'package:ecommerce/providers/user_provider.dart';
import 'package:ecommerce/screens/home/widgets/carousel_image.dart';
import 'package:ecommerce/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/screens/search/SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: GlobalVariables.getAppBar(
          context: context,
          wantBackNavigation: false,
          onClickSearchNavigateTo: const MySearchScreen()),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              const CarouselImage(),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
            ]),
          )
        ],
      )),
    );
  }
}
