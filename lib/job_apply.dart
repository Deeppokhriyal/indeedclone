import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
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
    fetchUserData();  // Laravel se user data fetch karenge
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rememberToken = prefs.getString('remember_token');
    print("Saved Token: $rememberToken");// Login ke time saved token

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

  // Future<void> _pickFile() async {
  //     try {
  //       FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.custom,
  //         allowedExtensions: ['pdf', 'docx'],
  //       );
  //     if (result != null && result.files.isNotEmpty) {
  //       setState(() {
  //         _selectedFile = File(result.files.single.path!);
  //       });
  //       print("✅ File Selected: ${_selectedFile!.path}");
  //     } else {
  //       print(" No file selected");
  //     }
  //   } catch (e) {
  //     print(" FilePicker Error: $e");
  //   }
  // }


  static Future<bool> requestPermission() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        if (await Permission.storage.request().isGranted) {
          return true;
        } else if (await Permission.storage.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.audio.request().isDenied) {
          return false;
        }
      } else {
        if (await Permission.photos.request().isGranted) {
          return true;
        } else if (await Permission.photos.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.photos.request().isDenied) {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      // IosDeviceInfo iosInfo = await plugin.iosInfo;
      if (await Permission.storage.request().isGranted) {
        return true;
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied) {
        return false;
      }
    }
    return false;
  }
  Future picImage() async {
    // print("fff");
    bool permission = await requestPermission();
    if (permission) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      // if(state is Updated) {
      //
      // }

      if (pickedFile != null) {
        // File? file = await Helper.cropImageFile(pickedFile.path);

      //   Result result = await Repository.instance.uploadFile(file, FileUploadType.PROFILE_IMG);
      //   if (result.success) {
      //     user.value.profilePic = result.value;
      //     user.refresh();
      //   }
      // } else {
      //   Toasty.failed('noImageSelected'.t);
      // }
    }
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
                onPressed: picImage,
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
