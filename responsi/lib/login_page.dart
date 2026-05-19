import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.find();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.gamepad, size: 80, color: Colors.blue),
            const SizedBox(height: 16),
            const Text('Hydra Games', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (emailCtrl.text.isNotEmpty && passCtrl.text.isNotEmpty) {
                    authController.login(emailCtrl.text, passCtrl.text);
                  }
                },
                child: const Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}