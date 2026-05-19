import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import 'library_controller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authCtrl = Get.find();
  final LibraryController libCtrl = Get.find();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Email:'),
                Obx(() => Text(authCtrl.userEmail.value)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Games Dimiliki:'),
                Obx(() => Text('${libCtrl.savedGames.length}')),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => authCtrl.logout(),
                child: const Text('Logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}