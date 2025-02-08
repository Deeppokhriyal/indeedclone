import 'package:flutter/material.dart';
import 'package:indeed/appliedpage.dart';
import 'package:indeed/archivedpage.dart';
import 'package:indeed/interviewspage.dart';
import 'package:indeed/savedpage.dart';

class Jobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Jobs',style: TextStyle(fontFamily: 'sans-serif-thin',fontSize: 25),),
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
        body: TabBarView(
          children: [
            SavedPage(),
            AppliedPage(),
            InterviewsPage(),
            ArchivedPage(),
          ],
        ),
      ),
    );
  }
}
