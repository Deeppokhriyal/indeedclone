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
    var url = Uri.parse("http://192.168.1.63:8000/api/job-applications");
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
    if (!cvUrl.contains("http://192.168.1.63:8000/storage/uploads/cvs/")) {
      cvUrl = "http://192.168.1.91:8000/storage/uploads/cvs/" + cvUrl.split('/').last;
    }
    Helper.openUrl(cvUrl);
  }

  Future<void> sendMessage(int jobSeekerId, int jobId, String status) async {
    var url = Uri.parse("http://192.168.1.63:8000/api/store-message");

    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {
        "job_seeker_id": jobSeekerId.toString(),
        "job_id": jobId.toString(),
        "status": status,
        "message": status == "accepted"
            ? "Your job application has been accepted."
            : "Sorry! Your job application has been denied.",
      },
    );

    if (response.statusCode == 200) {
      print("Message stored successfully");
    } else {
      print("Error storing message: ${response.body}");
    }
  }


  Future<void> handleApplication(int index, String status) async {
    var app = applications[index];
    if (app['id'] == null) {  // Check if ID is null
      print("Error: Application ID is null");
      return;
    }
    var url = Uri.parse("http://192.168.1.63:8000/api/update-application");
print(app['id'].toString());
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(app['id'].toString())));
    final response = await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {
        "id": app['id'].toString(),
        "status": status,
      },
    );

    if (response.statusCode == 200) {
      if (status == "denied") {
        setState(() {
          applications.removeAt(index);
        });
      }

      // Send Message to Job Seeker
      await sendMessage(app['job_seeker_id'], app['job_id'], status);

      // Send FCM Notification to Job Seeker
      await sendNotification(app['id'], status);
    } else {
      print("Error updating application: ${response.body}");
    }
  }


  Future<void> sendNotification(int id, String status) async {
    var url = Uri.parse("http://192.168.1.63:8000/api/send-notification");

    await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {
        "id": id.toString(),
        "message": status == "accepted"
            ? "Congratulations! Your application has been accepted."
            : "Sorry! Your application has been denied.",
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: applications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: applications.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          var app = applications[index];

          return Card(
            color: Colors.white,
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Job Title
                  Text(
                    "Applied for: ${app['job_title']}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      app['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${app['email']}"),
                        Text("Phone: ${app['phone']}"),
                        Text("Location: ${app['location']}"),
                        Text("Experience: ${app['experience']} years"),
                      ],
                    ),
                    trailing: ElevatedButton.icon(
                      onPressed: () => openCV(app['cv_url']),
                      icon: Icon(Icons.visibility),
                      label: Text("View CV"),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Accept & Deny Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => handleApplication(index, "denied"),
                        icon: Icon(Icons.close, color: Colors.red),
                        label: Text("Deny", style: TextStyle(color: Colors.red)),
                      ),
                      TextButton.icon(
                        onPressed: () => handleApplication(index, "accepted"),
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        label: Text("Accept", style: TextStyle(color: Colors.green)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
