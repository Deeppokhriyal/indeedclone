import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Helper.dart';

class EmployerDashboard extends StatefulWidget {
  @override
  _EmployerDashboardState createState() => _EmployerDashboardState();
}

class _EmployerDashboardState extends State<EmployerDashboard> {
  List<dynamic> applications = [];

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    var url = Uri.parse("http://192.168.1.91:8000/api/job-applications");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        applications = jsonDecode(response.body);
      });
    } else {
      print("Error fetching applications");
    }
  }

  Future<void> openCV(String cvUrl) async {
    if (!cvUrl.contains("http://192.168.1.91:8000/storage/uploads/cvs/")) {
      cvUrl = "http://192.168.1.91:8000/storage/uploads/cvs/" + cvUrl.split('/').last;
    }


    Helper.openUrl(cvUrl);
    // final Uri url = Uri.parse(cvUrl);
    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
    // } else {
    //   print("Could not open CV file: $cvUrl");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: applications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: applications.length,
        itemBuilder: (context, index) {
          var app = applications[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(app['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(app['email'], style: TextStyle(color: Colors.grey[700])),
                  Text(app['phone'], style: TextStyle(color: Colors.grey[700])),
                  Text("Location: ${app['location']}"),
                ],
              ),
              subtitle: Text("Experience: ${app['experience']} years"),
              trailing: ElevatedButton(
                onPressed: () => openCV(app['cv_url']),
                child: Text("View CV"),
              ),
            ),
          );
        },
      ),
    );
  }
}
