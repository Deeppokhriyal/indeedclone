import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:indeed/employer_homepage.dart';
import 'package:indeed/homepage.dart';
import 'package:indeed/jobs.dart';
import 'package:indeed/profilescreen.dart';
import 'package:indeed/saveditemprovider.dart';
import 'package:indeed/startingpage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  NotificationServices notificationServices = NotificationServices();
  notificationServices.firebaseInit();
  // notificationServices.handleBackgroundMessage(Get.context!);
  runApp(
    ChangeNotifierProvider(
      create: (context) => SavedItemsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? role;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserRole();
  }

  Future<void> getUserRole() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await Future.delayed(Duration(milliseconds: 500)); // Prevent blocking UI
      setState(() {
        role = prefs.getString('role');
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading role: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoading
          ? Center(child: CircularProgressIndicator()) // Prevent black screen
          : role == 'employer'
          ? HomeScreen()
          : role == 'job_seeker'
          ? MainScreen()
          : MyStaringPage(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = [
    MyHomePage(),
    Jobs(),
    Center(child: Text('Messages Screen')),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedIndex,
      builder: (context, index, child) {
        return WillPopScope(
          onWillPop: () async {
            if (index == 0) {
              return true;
            } else {
              _selectedIndex.value = 0;
              return false;
            }
          },
          child: Scaffold(
            body: IndexedStack(
              index: index,
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
              currentIndex: index,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.grey,
              onTap: (i) => _selectedIndex.value = i,
            ),
          ),
        );
      },
    );
  }
}
