import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/login_page.dart';
import 'package:flutter_application_2/controller/auth_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    print(authController.userName);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder<bool>(
        future: authController.isLoggedIn(), // Check login status
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Handle any errors
            return const Center(child: Text("Error checking login status."));
          }

          // If not logged in, show LoginPage
          if (snapshot.data == false) {
            return const LoginPage(); // User is not logged in, show LoginPage
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child:
                    Text("Welcome to the app!${authController.userName.value}"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await authController.logout();
                  Get.offAll(() => const LoginPage());
                },
                child: const Text("Logout"),
              ),
            ],
          );
        },
      ),
    );
  }
}
