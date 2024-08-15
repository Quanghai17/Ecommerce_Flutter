import 'package:ecommerce/providers/user_provider.dart';


import 'package:ecommerce/screens/account/widgets/account_button.dart';


import 'package:ecommerce/services/auth_services.dart';


import 'package:flutter/material.dart';


import 'package:provider/provider.dart';


class Information extends StatefulWidget {

  const Information({super.key});


  @override

  State<Information> createState() => _InformationState();

}


class _InformationState extends State<Information> {

  AuthService authService = AuthService();


  @override

  void initState() {

    super.initState();


    authService.getUserData(context);

  }


  @override

  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context).user;


    print(userProvider.name);


    return Container(

      padding: EdgeInsets.only(

        left: MediaQuery.of(context).size.width * 0.035,

        right: MediaQuery.of(context).size.width * 0.035,

        bottom: MediaQuery.of(context).size.width * 0.035,

      ),

      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          RichText(

            text: TextSpan(

                text: "Hello, ",

                style: const TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.bold,

                    color: Colors.black87),

                children: [

                  TextSpan(

                      text: userProvider.name.isNotEmpty
                          ? userProvider.name
                          : "User",

                      style: const TextStyle(

                          fontSize: 22,

                          fontWeight: FontWeight.bold,

                          color: Colors.black87))

                ]),

          ),

          AccountButton(

              text: "Đăng xuất", onTap: () => authService.signOut(context))

        ],

      ),

    );

  }

}

