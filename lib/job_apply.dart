import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:indeed/homepage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyJobScreen extends StatefulWidget {
  @override
  _ApplyJobScreenState createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  File? _selectedFile;
  String? name, email, phone;
  final ImagePicker _picker = ImagePicker();
  TextEditingController locationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rememberToken = prefs.getString('remember_token');

    if (rememberToken == null) {
      print("Token not found");
      return;
    }

    var url = Uri.parse("http://192.168.1.91:8000/api/get-user");
    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {"remember_token": rememberToken},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
        setState(() {
          name = data['user']['name'];
          email = data['user']['email'];
          phone = data['user']['phone'];
        });
    } else {
      print("Error fetching user data: ${response.body}");
    }
  }

  Future<bool> requestPermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        var status = await Permission.storage.request();
        return status.isGranted;
      } else {
        var status = await Permission.photos.request();
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      var status = await Permission.storage.request();
      return status.isGranted;
    }
    return false;
  }

  Future<void> pickFile() async {
    bool permission = await requestPermission();
    if (!permission) return;

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
        setState(() {
          _selectedFile = File(pickedFile.path);
        });
    }
  }

  Future<void> submitApplication(BuildContext context) async {
    if (name == null ||
        email == null ||
        phone == null ||
        locationController.text.isEmpty ||
        experienceController.text.isEmpty ||
        _selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all fields and upload CV")));
      return;
    }

    try {
      var url = Uri.parse("http://192.168.1.91:8000/api/apply-job");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? rememberToken = prefs.getString('remember_token');

      var request = http.MultipartRequest("POST", url);
      request.headers['Authorization'] = "Bearer $rememberToken";

      request.fields['name'] = name!;
      request.fields['email'] = email!;
      request.fields['phone'] = phone!;
      request.fields['location'] = locationController.text;
      request.fields['experience'] = experienceController.text;

      if (_selectedFile != null) {
        request.files.add(
            await http.MultipartFile.fromPath('cv', _selectedFile!.path));
      }

      var response = await request.send();

      final responseBody = await response.stream.bytesToString();
      print(" API Response: ${response.statusCode}");
      print(" Response Body: $responseBody");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Application submitted successfully")));

        // setState(() {
        //   locationController.clear();
        //   experienceController.clear();
        //   _selectedFile = null;
        // });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        ); // Home page pr wapas jaane ke liye
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to submit application")));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong! Try again.")));
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
              Text("Personal Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(name ?? ""),
              Text(email ?? ""),
              Text(phone ?? ""),
              SizedBox(height: 20),
              Text("Upload Your CV",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _selectedFile != null
                  ? Row(
                children: [
                  Icon(Icons.file_present, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selectedFile!.path.split('/').last,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _selectedFile = null;
                      });
                    },
                  ),
                ],
              )
                  : ElevatedButton.icon(
                onPressed: pickFile,
                icon: Icon(Icons.upload_file),
                label: Text("Upload CV"),
              ),
              SizedBox(height: 20),
              Text("Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: locationController,
                decoration: InputDecoration(hintText: "Enter your location"),
              ),
              SizedBox(height: 20),
              Text("Work Experience",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: experienceController,
                decoration:
                InputDecoration(hintText: "Enter years of experience"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed:()=> submitApplication(context),
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
                  child: Text("Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
