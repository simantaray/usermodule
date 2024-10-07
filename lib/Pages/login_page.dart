import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/signup_page.dart';

import 'package:flutter_application_2/controller/auth_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers to capture user input
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController authController = AuthController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle login logic here
                String username = usernameController.text;
                String password = passwordController.text;
                authController.login(username, password);
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => const SignupPage());
              },
              child: const Text('Register new user'),
            ),
          ],
        ),
      ),
    );
  }
}
