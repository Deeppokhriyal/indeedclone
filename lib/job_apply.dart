import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyJobScreen extends StatefulWidget {
  @override
  _ApplyJobScreenState createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  File? _selectedFile;
  String? name, email, phone;
  TextEditingController locationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();  // Laravel se user data fetch karenge
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rememberToken = prefs.getString('remember_token');
    print("🔹 Saved Token: $rememberToken");// Login ke time saved token

    if (rememberToken == null) {
      print("Token not found");
      return;
    }

    var url = Uri.parse("http://192.168.1.91:8000/api/get-user"); // Laravel API
    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {"remember_token": rememberToken},
    );
    print("🔹 API Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("✅ User Data: $data");
      setState(() {
        name = data['user']['name'];
        email = data['user']['email'];
        phone = data['user']['phone'];
      });
    } else {
      print("Error fetching user data: ${response.body}");
    }
  }

  Future<void> _pickFile() async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'docx'],
        );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
        print("✅ File Selected: ${_selectedFile!.path}");
      } else {
        print(" No file selected");
      }
    } catch (e) {
      print(" FilePicker Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Apply for Job"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personal Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(name ?? ""),
              Text(email ?? ""),
              Text(phone ?? ""),
              SizedBox(height: 20),
              Text("Upload Your CV", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _selectedFile != null
                  ? Text("Selected File: ${_selectedFile!.path.split('/').last}")
                  : ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.upload_file),
                label: Text("Upload CV"),
              ),
              SizedBox(height: 20),
              Text("Location", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: locationController,
                decoration: InputDecoration(hintText: "Enter your location"),
              ),
              SizedBox(height: 20),
              Text("Work Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: experienceController,
                decoration: InputDecoration(hintText: "Enter years of experience"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Yahan backend API call karke data submit karna h
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
