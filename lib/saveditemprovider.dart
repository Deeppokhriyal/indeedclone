import 'package:flutter/material.dart';
import 'package:indeed/data/job_data.dart';

class SavedItemsProvider with ChangeNotifier {
  final List<JobData> _savedjobs = [];

  List<JobData> get savedjobs => _savedjobs;

  void savejob(JobData job) {
    // if (!_savedjobs.contains(job)) {  // Prevent duplicate entries
      _savedjobs.add(job);
      notifyListeners();
    // }
  }

  void removejob(JobData job) {
    _savedjobs.remove(job);
    notifyListeners();
  }
}
