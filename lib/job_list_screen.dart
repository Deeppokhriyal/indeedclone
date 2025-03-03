import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:indeed/Job_Posted.dart';

class JobListScreen extends StatelessWidget {
  // late TabController _tabController;

  // @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Ensuring back icon is visible
        title: Text(
        'My Jobs',
        style: TextStyle(
        fontFamily: 'sans-serif-thin',
        fontSize: 22,
        fontWeight: FontWeight.bold,
    ),
    ),
    elevation: 1, // Light shadow for a clean look
    bottom: PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: TabBar(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    indicatorColor: Colors.blue, // Matching UI
    indicatorWeight: 3,
    tabs: [
    Tab(text: 'JOBS POSTED'),
    Tab(text: 'JOBS APPLIED'),
    ],
    ),
    ),
    ),
      body: TabBarView(
    children: [
    JobPosted(), // Placeholder
    Center(child: Text('Jobs Applied Page')), // Placeholder
    ],
    ),
    ),
    );
  }
}
