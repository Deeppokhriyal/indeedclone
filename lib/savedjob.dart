// // lib/saved_items_provider.dart
// import 'package:flutter/material.dart';
//
//
// class SavedItemsProvider with ChangeNotifier {
//   List<Job> _savedJobs = [];
//
//   List<Job> get savedJobs => _savedJobs;
//
//   void saveJob(Job job) {
//     _savedJobs.add(job);
//     notifyListeners();
//   }
//
//   void removeJob(Job job) {
//     _savedJobs.remove(job);
//     notifyListeners();
//   }
// }
//
// // lib/job.dart
// class Job {
//   final String title;
//   final String company;
//   final String location;
//
//   Job({required this.title, required this.company, required this.location});
// }