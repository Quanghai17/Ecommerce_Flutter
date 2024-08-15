import 'package:ecommerce/components/bottom_bar.dart';
import 'package:ecommerce/providers/user_provider.dart';
import 'package:ecommerce/providers/category_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/screens/auth/login_screen.dart';
import 'package:ecommerce/screens/auth/signup_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final token = snapshot.data;
        return MaterialApp(
          title: 'Ecommerce',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: token != null && token.isNotEmpty
              ? const BottomBar()
              : const LoginScreen(),
        );
      },
    );
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('x-auth-token');
  }
}
