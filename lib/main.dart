import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelapp/Screens/splash_screen.dart';
import 'blocs/application_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'home.dart';
import 'bottomnav.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

import 'services/local_push_notification.dart';

// Future<void> _handlebackgroundMessaging(RemoteMessage message) async {
//   /// Onclick listener
// }
//background services Notification
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    print("push notification");
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print(
            "FirebaseMessaging.instance.getInitialMessage-------------------");

        if (message != null) {
          print("New Notification ibrahim");
          LocalNotificationService.createanddisplaynotification(message);
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    //App Push Notification
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen 44444444444");
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     content: ListTile(
          //       title: Text(message.notification!.title.toString()),
          //       subtitle: Text(message.notification!.body.toString()),
          //     ),
          //     actions: <Widget>[
          //       FlatButton(
          //         color: Colors.amber,
          //         child: Text('Ok'),
          //         onPressed: () => Navigator.of(context).pop(),
          //       ),
          //     ],
          //   ),
          // );
        }
      },
    );
    //background state
    //if you are sending a notification message, and you clicked the notification then the onMessageOpenedApp will be called.
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data;
      LocalNotificationService.createanddisplaynotification(message);
      print(routeFromMessage);
      print('Message clicked!');
    });
    // onLaunch: (Map<String, dynamic> message) async {
    //       print("onLaunch: $message");
    //       // TODO optional
    //     },
    //     onResume: (Map<String, dynamic> message) async {
    //       print("onResume: $message");
    //       // TODO optional
    //     },
    //);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }

  /// Get the token, save it to the database for current user
  // _saveDeviceToken() async {
  //   // Get the current user
  //   String uid = 'jeffd23';
  //   // FirebaseUser user = await _auth.currentUser();

  //   // Get the token for this device
  //   String fcmToken = await _fcm.getToken();

  //   // Save it to Firestore
  //   if (fcmToken != null) {
  //     var tokens = _db
  //         .collection('users')
  //         .document(uid)
  //         .collection('tokens')
  //         .document(fcmToken);

  //     await tokens.setData({
  //       'token': fcmToken,
  //       'createdAt': FieldValue.serverTimestamp(), // optional
  //       'platform': Platform.operatingSystem // optional
  //     });
  //   }
  // }

  /// Subscribe the user to a topic
  // _subscribeToTopic() async {
  //   // Subscribe the user to a topic
  //   _fcm.subscribeToTopic('puppies');
  // }
}
