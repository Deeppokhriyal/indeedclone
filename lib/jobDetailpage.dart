import 'package:flutter/material.dart';

class JobDetailPage extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailPage({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(job['category']),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Title
              Text(
                job['job_title'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              // Company Name
              Text(
                job['company_name'],
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              // Location
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    job['location'],
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              // Salary
              Text(
                "Salary: ${job['salary']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(height: 10),
              // Job Type
              Text(
                "Job Type: ${job['job_position']}",
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              SizedBox(height: 10),
              // Shift Schedule
              Text(
                "Shift & Schedule: ${job['shift_schedule']}",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              // Job Description
              Text(
                "Job Description:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                job['job_description'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              // Job Requirements
              Text(
                "Job Requirements:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                job['job_requirements'],
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Apply Now Functionality
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Apply Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
