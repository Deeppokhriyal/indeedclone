import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indeed/homepage.dart';
import 'package:indeed/saveditemprovider.dart';
import 'package:provider/provider.dart';
import 'package:indeed/data/job_data.dart';

class SavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<SavedItemsProvider>(
        builder: (context, provider, child) {
          return provider.savedjobs.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/saved.png'),
                Text('No jobs saved yet'),
                SizedBox(height: 5),
                Text('Jobs you save appear here.'),
                SizedBox(height: 15),
                Text('Not seeing a job?'),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => MyHomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Text color
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Find jobs', style: TextStyle(color: Colors.white, fontFamily: 'nexalight')),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                )
              ],
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: provider.savedjobs.length,
            itemBuilder: (context, index) {
              final job = provider.savedjobs[index]; // Get saved job from provider
              return Card(
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
                      if (job.label.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: job.isNew ? Colors.redAccent : Colors.purpleAccent[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            job.label,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 8),
                      Text(
                        job.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        job.company,
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      Text(
                        job.location,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                      SizedBox(height: 8),
                      Text(
                        job.salary,
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      if (job.status.isNotEmpty)
                        Text(
                          job.status,
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.send, size: 16, color: Colors.blue),
                            label: Text(
                              'Easily apply',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark_border),
                            onPressed: () {
                              Provider.of<SavedItemsProvider>(context, listen: false).removejob(job);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
