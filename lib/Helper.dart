import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper{
  static void openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);if (url.endsWith('.pdf')) {
        // Open with a PDF viewer
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          print(" Could not open PDF: $url");
        }
      } else {
        // Open in browser
        if (!await launchUrl(uri, mode: LaunchMode.externalNonBrowserApplication)) {
          print(" Could not open CV file: $url");
        }
      }
    } catch (e) {
      debugPrint('Invalid URL: $e');
    }
  }
}