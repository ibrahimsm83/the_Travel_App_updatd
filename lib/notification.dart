import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({ Key? key }) : super(key: key);

  @override
  _NotifPageState createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {

  late FlutterLocalNotificationsPlugin  localNotif;
  @override
  void initState(){
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('logo');
    var iOSinit = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: androidInitilize, iOS: iOSinit);
    localNotif = new FlutterLocalNotificationsPlugin();
    localNotif.initialize(initSettings);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "Hello", 
      "The Travel App",
      importance: Importance.high
    );
    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails = new NotificationDetails(
      android: androidDetails,
      iOS: iosDetails
    );
    await localNotif.show(
      0, 
      "The Travel App", 
      "Hello", 
      generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: MaterialButton(
          onPressed:
            _showNotification,
            child: Text(
              "Notification",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontFamily: 'Montserrat',
              ),
            )
        )
      ),
    );
  }
}
