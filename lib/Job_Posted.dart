import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'jobDetailpage.dart';

class JobPosted extends StatefulWidget {
  const JobPosted({super.key});

  @override
  State<JobPosted> createState() => _JobPostedState();
}

class _JobPostedState extends State<JobPosted> {

  Future<List<dynamic>> fetchJobs() async {
    var url = Uri.parse('http://192.168.0.135:8000/api/jobs');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<dynamic>>(
          future: fetchJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No jobs available.'));
            } else {
              return ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var job = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => JobDetailPage(job: job),  ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(job['label'] != null && job['label'] != '')
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color:(job['is_new'].toString() != true)
                                      ?Colors.redAccent
                                      : Colors.purpleAccent[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  job['label'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            SizedBox(height: 8),
                            Text(
                              job['job_title'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              job['company_name'],
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 14),
                            ),
                            Text(
                              job['location'],
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                            ),
                            SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['salary'].toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                // Spacer(),
                                if (job['job_position'] != null &&
                                    job['job_position'] != '')
                                  Text(
                                    job['job_position'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                            if (job['shift_schedule'] != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4),
                                child: Text(
                                  job['shift_schedule'],
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                              ),
                            if (job['active'] != null && job['active'] != '')
                              Text(
                                job['active'],
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 12),
                              ),
                            SizedBox(height: 8),
                            if(job['salary'] != null && job['salary'] != '')
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.send, size: 16,
                                        color: Colors.blue),
                                    label: Text(
                                      'Easily apply',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon( Icons.bookmark
                                      // Provider.of<SavedItemsProvider>(context).savedjobs.contains(JobData.fromMap(job))
                                      //   ? Icons.bookmark
                                      //   : Icons.bookmark_border,
                                      // color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      // final jobObject = JobData.fromMap(job); // Convert Map to JobData
                                      // final savedProvider = Provider.of<SavedItemsProvider>(context, listen: false);
                                      //
                                      // if (savedProvider.savedjobs.contains(jobObject)) {
                                      //   savedProvider.removejob(jobObject);
                                      // } else {
                                      //   savedProvider.savejob(jobObject);
                                      // }
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
      ),
    );
  }
}
