import 'package:ecommerce/providers/user_provider.dart';
import 'package:ecommerce/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        themeMode: ThemeMode.system,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Scaffold(body: SignUpScreen()));
  }
}
