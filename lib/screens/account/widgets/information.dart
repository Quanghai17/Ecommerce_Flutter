import 'package:ecommerce/providers/user_provider.dart';
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
    authService.getUserData(context).then((_) {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      print(
          'User name: $user'); // In toàn bộ đối tượng user để kiểm tra dữ liệu
    });
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context).user;
    // print(user.name);
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
            text: const TextSpan(
                text: "Hello, ",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
                children: [
                  TextSpan(
                      text: "Guest",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87))
                ]),
          )
        ],
      ),
    );
  }
}
