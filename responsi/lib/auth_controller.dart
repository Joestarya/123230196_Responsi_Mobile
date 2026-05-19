import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail.value = prefs.getString('email') ?? '';
    isLoggedIn.value = userEmail.value.isNotEmpty;
  }

  Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    userEmail.value = email;
    isLoggedIn.value = true;
    Get.offAllNamed('/main'); 
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn.value = false;
    userEmail.value = '';
    Get.offAllNamed('/login');
  }
}