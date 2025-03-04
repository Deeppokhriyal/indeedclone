import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData;


  @override
  void initState() {
    super.initState();
    fetchUserData();
  }


  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rememberToken = prefs.getString('remember_token');

    if (rememberToken == null) {
      print("Remember Token not found");
      return;
    }

    var url = Uri.parse("http://192.168.1.91:8000/api/get-user");
    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {"remember_token": rememberToken},
    );

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body)['user'];
      });
    } else {
      print("Failed to fetch user data");
    }
  }

  @override
  Widget build(BuildContext context) {
    // String firstName = userData?['name']?.split(" ")[0] ?? "J";
    // String lastName = userData?['name']?.split(" ")[1] ?? "D";

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
            // Navigator.pop(context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
          }, icon: Icon(Icons.arrow_back)),
    title: Text('Profile'),
    centerTitle: true,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 0,
    actions: [
    IconButton(
    icon: Icon(Icons.menu),
    onPressed: () {},
    ),
    ],
    ),
    body:  userData == null
        ? Center(child: CircularProgressIndicator()) // Loading state
        : SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    "${userData!['name'][0]}${userData!['name'].split(" ").length > 1 ? userData!['name'].split(" ")[1][0] : ""}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData?['name'] ?? "",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      userData?['email'] ?? "",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text(userData?['phone'] ?? ""),
                    SizedBox(height: 4),
                    // Text(
                    //   "Dehradun City, Dehradun, Uttarakhand\n248005, IN",
                    //   style: TextStyle(color: Colors.grey[600]),
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Divider(),
            // ListTile(
            //   title: Text(
            //     "Resume",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            //   trailing: Icon(Icons.arrow_forward_ios, size: 16),
            //   subtitle: Text(
            //     "Indeed Resume\nUpdated 28 Jan 2025 - Searchable",
            //     style: TextStyle(color: Colors.grey[600]),
            //   ),
            //   leading: Icon(Icons.insert_drive_file_outlined, size: 32),
            //   onTap: () {},
            // ),
            Divider(),
            SizedBox(height: 20),
            Text(
              "Improve your job matches",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            buildOption(
              context,
              title: "Qualifications",
              subtitle: "Highlight your skills and experience.",
            ),
            buildOption(
              context,
              title: "Job preferences",
              subtitle:
              "Save specific details like minimum desired pay and schedule.",
            ),
            buildOption(
              context,
              title: "Hide jobs with these details",
              subtitle:
              "Manage the qualifications or preferences used to hide jobs from your search.",
            ),
            buildOption(
              context,
              title: "Ready to work",
              subtitle:
              "Let employers know that you're available to start working as soon as possible.",
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "©2025 Indeed - Cookies, Privacy and Terms",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    )
    );
  }
}
Widget buildOption(BuildContext context,
    {required String title, required String subtitle}) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(subtitle),
    trailing: Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {},
  );
}
