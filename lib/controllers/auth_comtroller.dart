import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indeed/employer_homepage.dart';
import 'package:indeed/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find(); // Singleton instance

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isChecked = false.obs; // Observable for checkbox state

  //  Login Function
  Future<void> login(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString("username");
    String? storedPassword = prefs.getString("password");
    bool isEmployer = prefs.getBool("isEmployer") ?? false;

    if (usernameController.text == storedUsername && passwordController.text == storedPassword) {
      if (isEmployer) {
        Get.offAll(() => HomeScreen()); // Navigate to employer UI
      } else {
        Get.offAll(() => MainScreen()); // Navigate to employee UI
      }
    } else {
      Get.snackbar("Error", "Invalid credentials", snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Signup Function
  Future<void> signup(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", usernameController.text);
    await prefs.setString("password", passwordController.text);
    await prefs.setBool("isEmployer", isChecked.value);

    Get.snackbar("Success", "Account Created Successfully", snackPosition: SnackPosition.BOTTOM);
    Navigator.pop(context); // Navigate back to login page
  }
}
