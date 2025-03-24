import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationServices{
  NotificationServices(){
    getDeviceToken();
  }
  FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  /// ****** notification permission may for android 13 or more ******
  void requestNotificationPermission()async{

    NotificationSettings settings=await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: false
    );

    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      // Logger.m(tag: "FIREBASE PERMISSION: ",value:"user granted permission" );
    }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      // Logger.m(tag: "FIREBASE PERMISSION: ",value:"user granted provisional" );
    }
    else{
      // Logger.m(tag: "FIREBASE PERMISSION: ",value:"user denied permission" );
    }
  }


  /// ****** notification handling like render screens  *******
  void initLocalNotifications(RemoteMessage message)async{
    var androidInitialization=const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSetting=InitializationSettings(
      android: androidInitialization,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload){
        // handleMessages(message);
      },
      // onDidReceiveBackgroundNotificationResponse: (payload) {
      //   handleMessages(context,message);
      // }
    );
  }


  ///  ***** starting point of notification ******
  void firebaseInit(){
    FirebaseMessaging.onMessage.listen((message) {
      if(Platform.isAndroid){
        initLocalNotifications(message);
        showNotification(message);
      }
      else{
        showNotification(message);
      }
    });
  }


  ///******  for showing notification on foreground
  Future<void> showNotification(RemoteMessage message) async{
    AndroidNotificationChannel androidNotificationChannel=AndroidNotificationChannel(
        Random().nextInt(1000).toString(),
        "high importance notification",
        importance: Importance.max
    );

    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
      androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      channelDescription: "your channel discription",
      importance: Importance.high,
      priority: Priority.high,
      ticker: "ticker",
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('notification')
    );


    NotificationDetails notificationDetails=NotificationDetails(
      android: androidNotificationDetails,
    );


    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationsPlugin.show(
          DateTime.now().millisecond,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails
      );
    }

    );
  }


  /// ***** render on screens through notification type background   ******
  Future<void> handleBackgroundMessage(BuildContext? context) async{
    // when app is terminated
    if(context==null){
      return;
    }
    RemoteMessage? intMessage=await FirebaseMessaging.instance.getInitialMessage();
    if(intMessage!=null){
      // handleMessages(intMessage);
    }


    // when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

    });
  }





  Future<void> getDeviceToken() async {
    // print)()
    // try {
    //   String? token = await firebaseMessaging.getToken();
    //   print("FCM TOKEN: ${token}");
    //
    //   if (token == null) return;
    //
    //   // Get User ID from Laravel API
    //   var userUrl = Uri.parse("http://192.168.1.63:8000/api/login");
    //   var userResponse = await http.post(userUrl, headers: {
    //     "Authorization": "Bearer YOUR_ACCESS_TOKEN",
    //     "Accept": "application/json",
    //   });
    //
    //   if (userResponse.statusCode != 200) {
    //     print(" Failed to fetch user data: ${userResponse.body}");
    //     return;
    //   }
    //
    //   var userData = jsonDecode(userResponse.body);
    //   String id = userData['id'].toString();
    //
    //   // Send FCM Token to Laravel API
    //   var fcmUrl = Uri.parse("http://192.168.1.63:8000/api/get-device-token");
    //   var response = await http.post(
    //     fcmUrl,
    //     headers: {"Content-Type": "application/json"},
    //     body: jsonEncode({
    //       "id": id.toString(),
    //       "fcm_token": token,
    //     }),
    //   );
    //
    //   print(" API Response: ${response.body}");
    //
    //   if (response.statusCode == 200) {
    //     print(" FCM Token updated successfully");
    //   } else {
    //     print(" Failed to update FCM Token: ${response.body}");
    //   }
    // } catch (e) {
    //   print("Error updating FCM Token: $e");
    // }
    String? token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Id = prefs.getString('id');


    if (Id == null) {
      print("❌ User ID Not Found");
      return;
    }

    var url = Uri.parse("http://192.168.1.63:8000/api/get-device-token");
    await http.post(
      url,
      headers: {"Accept": "application/json"},
      body: {"id": Id, "fcm_token": token},
    );
  }




  void  isRefreshToken() async{
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      // debugPrint("refresh");
    });
  }

}