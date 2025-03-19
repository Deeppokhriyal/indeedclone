import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper{
  static void openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Invalid URL: $e');
    }
  }
}