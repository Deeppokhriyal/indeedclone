import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:indeed/homepage.dart';

class ArchivedPage extends StatefulWidget {
  final int jobSeekerId;

  ArchivedPage({required this.jobSeekerId});

  @override
  State<ArchivedPage> createState() => _ArchivedPageState();
}

class _ArchivedPageState extends State<ArchivedPage> {
  List<dynamic> messages = [];
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  Future<List<dynamic>> fetchMessages(int jobSeekerId) async {
    try {
      var url = Uri.parse("http://192.168.1.63:8000/api/get-messages?job_seeker_id=$jobSeekerId");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error fetching messages: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Network error: $e");
      return [];
    }
  }

  Future<void> loadMessages() async {
    var data = await fetchMessages(widget.jobSeekerId);
    setState(() {
      messages = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Archived Messages")),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : messages.isEmpty
          ? Center(  // ✅ Fix: Center the empty state UI
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/archived.png', height: 100),
            SizedBox(height: 10),
            Text('No messages yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('Messages related to job applications will appear here.', textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Get.to(MyHomePage()),
              icon: Icon(Icons.search),
              label: Text('Find Jobs', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          var message = messages[index];
          return Card(
            color: message['status'] == "accepted" ? Colors.green[50] : Colors.red[50],
            child: ListTile(
              title: Text(message['message'], style: TextStyle(fontSize: 16)),
              subtitle: Text("Status: ${message['status']}"),
            ),
          );
        },
      ),
    );
  }
}
