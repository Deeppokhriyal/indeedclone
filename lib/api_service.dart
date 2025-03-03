import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "http://192.168.0.135:8000/api";

  // Register user
  static Future<Map<String, dynamic>?> register(String name, String email,String phone, String password, String role) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email, "phone": phone, "password": password, "role": role}),
    );

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
      final data = jsonDecode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', data['user']['role']);
      await prefs.setString('phone', data['user']['phone']); // Phone number store

      return data;
    }
    return null;
  }
}
