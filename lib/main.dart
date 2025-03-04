import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:indeed/employer_homepage.dart';
import 'package:indeed/homepage.dart';
import 'package:indeed/jobs.dart';
import 'package:indeed/profilescreen.dart';
import 'package:indeed/saveditemprovider.dart';
import 'package:indeed/startingpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? role = prefs.getString('role');

  runApp(
    ChangeNotifierProvider(
      create: (context) => SavedItemsProvider(),
      child: MyApp(initialRoute: role),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? initialRoute;

  MyApp({this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialRoute == 'employer'
          ? HomeScreen()
          : initialRoute == 'job_seeker'
          ? MainScreen()
          : MyStaringPage(), // Login ya Starting Page
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyHomePage(),
    Jobs(),
    Center(child: Text('Messages Screen')),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async{
        if(_selectedIndex==0){
          return true;
        }
        else{
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }

      }
     ,

      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     _selectedIndex == 0
        //         ? 'Home'
        //         : _selectedIndex == 1
        //         ? 'My Jobs'
        //         : _selectedIndex == 2
        //         ? 'Messages'
        //         : 'Profile',
        //   ),
        //   backgroundColor: Colors.blueAccent,
        // ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
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
        ),
      ),
    );
  }
}

