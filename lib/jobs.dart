import 'package:flutter/material.dart';
import 'package:indeed/appliedpage.dart';
import 'package:indeed/archivedpage.dart';
import 'package:indeed/interviewspage.dart';
import 'package:indeed/savedpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jobs extends StatefulWidget {
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  int? jobSeekerId; // Store job seeker ID

  @override
  void initState() {
    super.initState();
    loadJobSeekerId();
  }

  Future<void> loadJobSeekerId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      jobSeekerId = prefs.getInt('job_seeker_id'); // Fetch from SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My Jobs',
            style: TextStyle(fontFamily: 'sans-serif-thin', fontSize: 25),
          ),
          bottom: TabBar(
            labelColor: Colors.blueAccent,
            indicatorColor: Colors.blueAccent,
            tabs: [
              Tab(text: 'Saved'),
              Tab(text: 'Applied'),
              Tab(text: 'Interviews'),
              Tab(text: 'Archived'),
            ],
          ),
        ),
        body: jobSeekerId == null
            ? Center(child: CircularProgressIndicator()) // Show loader until jobSeekerId loads
            : TabBarView(
          children: [
            SavedPage(),
            AppliedPage(),
            InterviewsPage(),
            ArchivedPage(jobSeekerId: jobSeekerId!), // Now it gets the correct ID
          ],
        ),
      ),
    );
  }
}
