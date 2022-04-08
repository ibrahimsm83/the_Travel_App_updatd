import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/Screens/main_screen.dart';
import 'package:travelapp/Utils/constants.dart';
import 'package:travelapp/services/database_helper.dart';

import 'Screens/history.dart';

class ProPage extends StatefulWidget {
  const ProPage({Key? key}) : super(key: key);

  @override
  _ProPageState createState() => _ProPageState();
}

class _ProPageState extends State<ProPage> {
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
            stream: Database.readuserdata(),
            builder: (context, snapshot) {
              if (snapshot.hasError && snapshot.data == null) {
                return Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data!.docs[index]['UEmail'] == eml) {
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
                                    snapshot.data!.docs[index]['uname'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['UEmail'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
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
                                        'History',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      trailing: new Icon(Icons.history_rounded),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        HistoryPage()));
                                      }),
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
                                            await SharedPreferences
                                                .getInstance();
                                        await //prefs?.clear();
                                            prefs.clear();
                                        await prefs.remove('useremail');
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MainScreen()));
                                      })
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
            SizedBox(height: 30.0),
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
            SizedBox(height: 15),
            // Container(
            //   //color: Colors.amber,
            //   //height: 150,
            //   width: sizeWidth(context),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Driver",
            //         style: TextStyle(
            //             fontSize: 38,
            //             fontWeight: FontWeight.bold,
            //             fontStyle: FontStyle.italic,
            //             color: Colors.white),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Container(
            //           height: 40,
            //           width: 40,
            //           child: Image.asset(
            //             "$imgpath/car.png",
            //             color: Colors.black,
            //             height: 40,
            //             width: 40,
            //             //  cacheColorFilter: true,
            //           )),
            //     ],
            //   ),
            // ),

            //SizedBox(height: 5),

            // SizedBox(height: 10.0),
            // Text(
            //   'Driver at your spot',
            //   style: TextStyle(color: Colors.white),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Divider(
            //   height: 5,
            //   thickness: 1,
            //   color: Colors.white,
            // ),

            // SizedBox(
            //   height: 30.0,
            // ),

            // SizedBox(
            //   height: 10.0,
            // ),
            /* //Login Buttons
            Container(
                width: sizeWidth(context),
                margin: EdgeInsets.only(left: btnmargsize, right: btnmargsize),
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: ElevatedButton(
                  child: Text(
                    "Find Driver",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    print("access --------------------------loc");
                    var position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    var lat = position.latitude;
                    var long = position.longitude;
                 
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomemapPage()));

                    // MaterialPageRoute(builder: (context) => CustomemapPage(latitud: lat,longit: long ,showallmech: _checkbox,)));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primaryColor,
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                )),*/
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
              height: 1,
            ),
            Divider(
              height: 0.1,
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
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
    var stringValue = prefs.getString('useremail');
    setState(() {
      eml = stringValue;
    });
    // return stringValue;
  }
}
