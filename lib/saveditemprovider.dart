import 'package:flutter/material.dart';
import 'package:indeed/data/job_data.dart';


class SavedItemsProvider with ChangeNotifier {
  final List<jobdata> _savedjobs = [];

  List<jobdata> get savedjobs => _savedjobs;

  void savejob(jobdata job) {
    if (!_savedjobs.contains(job)) {  // Prevent duplicate entries
      _savedjobs.add(job);
      notifyListeners();
    }
  }

  void removejob(jobdata job) {
    _savedjobs.remove(job);
    notifyListeners();
  }
}
