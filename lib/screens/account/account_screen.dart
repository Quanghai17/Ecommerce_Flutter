import 'package:ecommerce/screens/account/widgets/information.dart';
import 'package:ecommerce/screens/search/SearchScreen.dart';
import 'package:ecommerce/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 202, 201, 201),
      appBar: GlobalVariables.getAppBar(
          context: context,
          title: 'Thông tin cá nhân ',
          wantBackNavigation: false,
          onClickSearchNavigateTo: const MySearchScreen()),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.035,
          ),
          const Information(),
        ],
      ),
    );
  }
}
