import 'package:ecommerce/components/custom_textfield.dart';
import 'package:ecommerce/screens/auth/login_screen.dart';
import 'package:ecommerce/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthService authService = AuthService();

  void signupUser() {
    authService.signUpUser(
        context: context,
        name: nameController.text,
        password: passwordController.text,
        email: emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        const Text(
          "Đăng kí",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextField(
              controller: nameController, hintText: 'Họ và tên'),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child:
              CustomTextField(controller: emailController, hintText: 'Email'),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomTextField(
              controller: passwordController, hintText: 'Mật khẩu'),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: signupUser,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            textStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white),
            ),
          ),
          child: const Text(
            "Đăng kí",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text('Bạn đã có tài khoản? Đăng nhập'))
      ]),
    );
  }
}
