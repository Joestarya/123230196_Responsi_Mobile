import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'game_local_model.dart';
import 'auth_controller.dart';
import 'library_controller.dart';
import 'login_page.dart';
import 'main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GameLocalAdapter());
  await Hive.openBox<GameLocal>('libraryBox');

  // Inject Controllers
  Get.put(AuthController());
  Get.put(LibraryController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();
    
    return GetMaterialApp(
      title: 'Hydra Games',
      theme: ThemeData.dark(), // Sesuai mockup yang dominan gelap
      initialRoute: auth.isLoggedIn.value ? '/main' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/main', page: () => MainPage()),
      ],
    );
  }
}