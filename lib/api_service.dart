import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_services.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.63:8000/api";

  // Register user
  static Future<Map<String, dynamic>?> register(String name, String email,String phone, String password, String role) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "phone": phone, "password": password, "role": role}),
    );
Get.back();
    return response.statusCode == 201 ? jsonDecode(response.body) : null;
  }

  // Login user
  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String Id = data['user']['id'].toString(); // User ID from API
      // String? token = await FirebaseMessaging.instance.getToken();
      String rememberToken = data['remember_token'].toString();
      // String Id = data['id'].toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('remember_token', rememberToken);
      await prefs.setString('role', data['user']['role']);
      await prefs.setString('id', Id);
      NotificationServices();
      // await http.post(
      //   Uri.parse("http://192.168.1.63:8000/api/get-device-token"),
      //   headers: {"Accept": "application/json"},
      //   body: {"id": Id, "fcm_token": token},
      // );

      print("✅ FCM Token Stored for User: $Id");
      return data;
    }
    // else{print("❌ Login Failed");}
    return null;
  }
}
