import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indeed/homepage.dart';

import 'main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    body: SingleChildScrollView(
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
                    "DP",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Deepak Pokhriyal",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "dpokhriyal624@gmail.com",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text("072489 17717"),
                    SizedBox(height: 4),
                    Text(
                      "Dehradun City, Dehradun, Uttarakhand\n248005, IN",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              title: Text(
                "Resume",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              subtitle: Text(
                "Indeed Resume\nUpdated 28 Jan 2025 - Searchable",
                style: TextStyle(color: Colors.grey[600]),
              ),
              leading: Icon(Icons.insert_drive_file_outlined, size: 32),
              onTap: () {},
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              "Improve your job matches",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
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
