import 'package:flutter/material.dart';
import 'package:indeed/employer_uploadjob.dart';
import 'package:indeed/startingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadJobScreen(),
    );
  }
}

class UploadJobScreen extends StatelessWidget {
  final List<Map<String, dynamic>> jobCategories = [
    {'icon': Icons.design_services, 'label': 'Design'},
    {'icon': Icons.account_balance, 'label': 'Finance'},
    {'icon': Icons.school, 'label': 'Education'},
    {'icon': Icons.restaurant, 'label': 'Restaurant'},
    {'icon': Icons.health_and_safety, 'label': 'Health'},
    {'icon': Icons.code, 'label': 'Programmer'},
  ];

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Role remove karo
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyStaringPage()), // Login page par redirect
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Upload Job',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GridView.builder(
                itemCount: jobCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return JobCategoryCard(
                    icon: jobCategories[index]['icon'],
                    label: jobCategories[index]['label'],
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadJob()));
            },
            child: Container(
              width: 500,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(15),
              color: Colors.blue,
              child: Center(
                child: Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JobCategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  JobCategoryCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue[200]),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
