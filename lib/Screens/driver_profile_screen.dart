import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/Driver/driver_main_page.dart';
import 'package:travelapp/Screens/main_screen.dart';
import 'package:travelapp/Utils/constants.dart';
import 'package:travelapp/services/database_helper.dart';
import 'package:travelapp/services/local_push_notification.dart';



class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({Key? key}) : super(key: key);

  @override
  _DriverProfileScreenState createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF21BFBD),
//       body:Center(child: Text("Support")),
//     );
//   }
// }

  @override
  void initState() {
   
    //getCurrentLocation();
    getStringValuesSF();
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
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
    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    super.initState();
  }

  var locationMessage = '';
  String? latitude;
  String? longitude;
  String? eml;
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings

    setState(() {
      latitude = "$lat";
      longitude = "$long";
      locationMessage = "Latitude: $lat and Longitude: $long";
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _checkbox = false;

    final double btnmargsize = MediaQuery.of(context).size.width * 0.09;
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey[800],
        title: new Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
        toolbarHeight: 70.0,
        elevation: 5.0,
      ),
      drawer: SafeArea(
        child: new Drawer(
          child: StreamBuilder<QuerySnapshot>(
            stream: Database.readDriverData(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError && snapshot.data == null) {
                return Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                print(snapshot.data?.docs.length);
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data!.docs[index]['Email'] == eml) {
                        return Column(
                          children: [
                            Container(
                              height: 200,
                              width: sizeWidth(context),
                              color: Colors.grey[800],
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "User",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['Email'],
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  new ListTile(
                                    title: new Text(
                                      'Profile',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    trailing: new Icon(Icons.account_box),
                                  ),
                                  new ListTile(
                                    title: new Text(
                                      'Help',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    trailing: new Icon(Icons.help),
                                  ),
                                  new ListTile(
                                    title: new Text(
                                      'Sign out',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    trailing: new Icon(Icons.close),
                                    //onTap: ()=>Navigator.of(context).pop(),
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await //prefs?.clear();
                                          prefs.clear();
                                      await prefs.remove('driveremail');
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MainScreen()));
                                    },
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      } else
                        return SizedBox();
                    });
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      body: Container(
        //carmech1
        height: sizeheight(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.darken),
            image: AssetImage('$imgpath/carbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50.0),
            RichText(
                text: TextSpan(
                    text: 'Welcome to ',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Travel App ',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ))
                ])),
            SizedBox(height: 150.0),
            Container(
              //color: Colors.amber,
              //height: 150,
              width: sizeWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Driver",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "$imgpath/car.png",
                        color: Colors.black,
                        height: 40,
                        width: 40,
                        //  cacheColorFilter: true,
                      )),
                ],
              ),
            ),

            SizedBox(height: 20),

            SizedBox(height: 10.0),
            // Text(
            //   'Driver at your spot',
            //   style: TextStyle(color: Colors.black),
            // ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 5,
              thickness: 1,
              color: Colors.black,
            ),
            // FlatButton(
            //   color: Colors.white,
            //   onPressed: () {
            //     getCurrentLocation();
            //   },
            //   child: Text("Get User Location"),
            // ),
            SizedBox(
              height: 30.0,
            ),
            // Text(
            //   locationMessage,
            //   style: TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            /* Container(
              margin: EdgeInsets.only(left: 10),
              height: 40,
              //width: 400,
              //color: primaryColor,
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.white,
                    child: Checkbox(

                      value: _checkbox,
                      onChanged: (value) {
                        setState(() {
                          _checkbox = !_checkbox;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Show all Mechanics',
                    style: TextStyle(color: Colors.white),),
                ],
              ),
            ),*/
            SizedBox(
              height: 10.0,
            ),
            //Login Buttons
            Container(
                width: sizeWidth(context),
                margin: EdgeInsets.only(left: btnmargsize, right: btnmargsize),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: ElevatedButton(
                  child: Text(
                    "Find Trips",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DriverMainPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[800],
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                )),
            // Container(
            //   width: sizeWidth(context),
            //   margin: EdgeInsets.only(left: btnmargsize,right:btnmargsize ),
            //   color: Colors.red,
            //   child: ElevatedButton(
            //       onPressed: (){
            //         print("access --------------------------loc");
            //         print(longitude);
            //         print(latitude);
            //         // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => GoogleMapPg(longitude,latitude)));
            //
            //         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => CustomemapPage()));
            //
            //       },
            //       child: Text("Find Mechanic",style: TextStyle(fontSize: 18),
            //       ) ),
            // ),
            SizedBox(
              height: 50,
            ),
            Divider(
              height: 5,
              thickness: 1,
              color: Colors.black,
            ),
            //   Container(
            //     height: 400,
            //     color: Colors.blue,
            //     child: Align(
            //         alignment: Alignment.bottomCenter,
            //         child: Text("Map",style: TextStyle(fontSize: 32),)),
            //   )
            // new Center(
            //     child:new
            //     Text('Yahn per mechanic ko dekhne k lye geo locator chahye',style: TextStyle(
            //
            //
            //       fontSize: 50.0,
            //       color: Colors.green
            //     ),),
            //
            //
            // ),
          ],
        ),
      ),
    );
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    var stringValue = prefs.getString('driveremail');
    setState(() {
      print("-------------------------------");
      eml = stringValue;
      print(eml);
    });
    // return stringValue;
  }
}
