import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/home_page.dart';
import 'package:flutter_application_2/controller/auth_controller.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        title: const Text('Register new User'),
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
                String username = usernameController.text;
                String password = passwordController.text;
                authController.register(username, password);
              },
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => const HomePage());
              },
              child: const Text('already have a account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
