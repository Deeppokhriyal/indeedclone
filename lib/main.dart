import 'package:flutter/material.dart';

import 'data/job_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indeed App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Indeed App',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Center(child: Text('Home Screen')),
    Center(child: Text('My Jobs Screen')),
    Center(child: Text('Messages Screen')),
    Center(child: Text('Profile Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image(
            image: AssetImage("assets/images/Indeedlogo.jpg",),height: 100,width: 100,),

        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body:  _selectedIndex == 0
          ?Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 10,),
        Container(
          width: 500,
          margin: EdgeInsets.only(left: 15,right: 15),
          decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)),
                boxShadow:[ BoxShadow(
                  color: Colors.grey,
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
            ]
            ),
          child:
          TextField(style: TextStyle( fontFamily: 'sans-serif-light',height: 1.2,color: Colors.white),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,size: 20,color: Colors.black),
              fillColor: Colors.black,
              hintText: 'Job title,keywords,or company',hintStyle: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'sans-serif-thin'),
              border: OutlineInputBorder( // Unfocused border color
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),// Focused border color
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)),
                  ),
            ),


          ),
        ),
        Container(
              width: 500,
              margin: EdgeInsets.only(left: 15,right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
                  boxShadow:[ BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(3, 5),
                  ),
                  ]
              ),
              child:
              TextField(style: TextStyle( fontFamily: 'sans-serif-light',height: 1.2,color: Colors.white),
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on_sharp,size: 20,color: Colors.black),
                  fillColor: Colors.black,
                  hintText: 'Enter city or locality',hintStyle: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'sans-serif-thin'),
                  border: OutlineInputBorder( // Unfocused border color
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),// Focused border color
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10)),
                  ),
                ),
              ),
            ),

            SizedBox(height: 32.0),
            Text(
              'Jobs for you',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Jobs based on your activity on Indeed',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: jobdata.jobs.length,
                itemBuilder: (context, index) {
                  final job = jobdata.jobs[index];
                  return Card(
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
                          if (job['label'] != null)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: job['isNew'] ? Colors.redAccent : Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                job['label'],
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          SizedBox(height: 8),
                          Text(
                            job['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            job['company'],
                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                          ),
                          Text(
                            job['location'],
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job['salary'],
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              // Spacer(),
                              if (job['status'] != null)
                                Text(
                                  job['status'],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                          if (job['type'] != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                job['type'],
                                style: TextStyle(color: Colors.black54, fontSize: 12),
                              ),
                            ),
                          if (job['active'] != null && job['active'] != '')
                            Text(
                              job['active'],
                              style: TextStyle(color: Colors.grey[500], fontSize: 12),
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
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]
        ),
      )
              : _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.work),
    label: 'My Jobs',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.message),
    label: 'Messages',
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
    ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: Colors.blueAccent,
    unselectedItemColor: Colors.grey,
    onTap: _onItemTapped,
        backgroundColor: Colors.white,
    ),
    );
  }
}