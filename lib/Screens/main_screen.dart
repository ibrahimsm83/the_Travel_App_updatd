import 'package:flutter/material.dart';
import 'package:travelapp/Screens/login_admin_screen.dart';
import 'package:travelapp/Screens/login_driver_screen.dart';
import 'package:travelapp/Screens/login_user_screen.dart';
import 'package:travelapp/Utils/constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final double btnmargsize = MediaQuery.of(context).size.width * 0.09;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("$imgpath/signupsocialmedia.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: sizeheight(context) * 0.15),
                  child: Text("The Travel App",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal)),
                ),
                SizedBox(height: 20),
                Divider(height: 5, thickness: 1, color: Colors.white),
                SizedBox(height: sizeheight(context) * 0.15),
                SizedBox(height: 70.0),
                Text(
                  'For Users',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: sizeWidth(context),
                  margin:
                      EdgeInsets.only(left: btnmargsize, right: btnmargsize),
                  child: RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => LoginPage()));
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primaryColor),
                ),
                SizedBox(width: 20.0),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'For Driver',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: sizeWidth(context),
                  margin:
                      EdgeInsets.only(left: btnmargsize, right: btnmargsize),
                  child: RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => DriverLoginPage()));
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primaryColor),
                ),
                SizedBox(width: 20.0),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'For Admin',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: sizeWidth(context),
                  margin:
                      EdgeInsets.only(left: btnmargsize, right: btnmargsize),
                  child: RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => AdminLoginPage()));
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
