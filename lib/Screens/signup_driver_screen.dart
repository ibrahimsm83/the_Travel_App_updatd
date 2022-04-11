import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelapp/Screens/login_driver_screen.dart';
import 'package:travelapp/Utils/constants.dart';
import 'package:travelapp/services/database_helper.dart';

//import 'package:meconline/HomePage.dart';
//Saving Token

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  // String userId = FirebaseAuth.instance.currentUser!.uid;
  // print("device userId is created ${userId}");
  //var data = await FirebaseFirestore.instance.collection('Drivers').doc().get();
  //print(data);
  await FirebaseFirestore.instance
      .collection('Drivers')
      .doc("342312345")
      .update({
    'tokens': //token,
        FieldValue.arrayUnion([token]),
  });
}

class SignUpDriverPage extends StatefulWidget {
  @override
  _SignUpDriverPageState createState() => _SignUpDriverPageState();
}

class _SignUpDriverPageState extends State<SignUpDriverPage> {
  var locationMessage = '';
  String? latitude;
  String? longitude;
  //loaction
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

  late String _token;
//  setupToken();
  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();
    log("device token is created ${token}");
    // Save the initial token to the database
    await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  //snackbar message
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? _success;
  String? _mechemail;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phonenoController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _servicesController = TextEditingController();
  final TextEditingController _seatsController = TextEditingController();
  String? dropdownvalue = "Select Service";
  //int var = int.parse(_seatsController.text);

  String? _email, _password, _name;
  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phonenoController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _servicesController.dispose();
    _seatsController.dispose();
    super.dispose();
  }

  clearTextInput() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _phonenoController.clear();
    _cityController.clear();
    _addressController.clear();
    _servicesController.clear();
    _seatsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
              //height: sizeheight(context)*1.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('$imgpath/carbackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Icon(
                  Icons.how_to_reg,
                  size: 200,
                  color: primaryColor,
                ),
                Container(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Driver Register',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            /*--------------------------------name---------------------------------------------*/
                            Container(
                              child: TextFormField(
                                // ignore: missing_return
                                controller: _nameController,

                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (input) {
                                  if (input == null) return 'Enter Name';
                                },
                              ),
                            ),
                            /*--------------------------------phoneno---------------------------------------------*/
                            Container(
                              child: TextFormField(
                                controller: _phonenoController,
                                decoration: InputDecoration(
                                  labelText: 'WhatsApp Number',
                                  prefixIcon: Icon(Icons.phone_missed_sharp),
                                ),
                                validator: (input) {
                                  if (input == null) return 'Enter Number';
                                },
                              ),
                            ),
                            /*--------------------------------city---------------------------------------------*/
                            Container(
                              child: TextFormField(
                                validator: (input) {
                                  if (input == null) return 'Enter City';
                                },
                                controller: _cityController,
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  prefixIcon: Icon(Icons.location_city),
                                ),
                                // onSaved: (input) => _name = input),
                              ),
                            ),

                            /*--------------------------------address---------------------------------------------*/
                            Container(
                              child: TextFormField(
                                  validator: (input) {
                                    if (input == null) return 'Enter address';
                                  },
                                  controller: _addressController,
                                  decoration: InputDecoration(
                                    labelText: 'Address',
                                    prefixIcon: Icon(
                                      Icons.location_on_outlined,
                                    ),
                                  ),
                                  onSaved: (input) => _name = input),
                            ),
/*--------------------------------------Services----------------------------------------*/
                            Container(
                              child: TextFormField(
                                  validator: (input) {
                                    if (input == null) return 'Enter Service';
                                  },
                                  controller: _servicesController,
                                  decoration: InputDecoration(
                                    labelText: 'Car Type',
                                    prefixIcon: Icon(
                                      Icons.car_rental,
                                    ),
                                  ),
                                  onSaved: (input) =>
                                      _servicesController.text = input!),
                            ),
                            /*--------------------------------email---------------------------------------------*/
                            Container(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email)),
                                validator: (input) {
                                  if (input == null) return 'Enter Email';
                                },
                              ),
                            ),
                            /*--------------------------------password---------------------------------------------*/
                            Container(
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                                validator: (input) {
                                  if (input == null) return 'Enter password';
                                },
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                controller: _seatsController,
                                decoration: InputDecoration(
                                  labelText: 'No. of Seats',
                                  prefixIcon: Icon(Icons.event_seat_sharp),
                                ),
                                validator: (input) {
                                  if (input == null)
                                    return 'Enter no. of seats';
                                },
                              ),
                            ),
                            Container(
                              child: DropdownButtonFormField<String>(
                                //value: dropdownvalue,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.emoji_transportation),
                                ),
                                hint: Text('Select Service'),
                                items: <String>[
                                  'Daily Rides',
                                  'Sharing',
                                  'Intercity',
                                  'Event'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    dropdownvalue = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            // ignore: deprecated_member_use
                            RaisedButton(
                              padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  String? devicetoken = await FirebaseMessaging
                                      .instance
                                      .getToken();
                                  if (_nameController.text.isNotEmpty &&
                                      _phonenoController.text.isNotEmpty &&
                                      _cityController.text.isNotEmpty &&
                                      _addressController.text.isNotEmpty &&
                                      _servicesController.text.isNotEmpty &&
                                      _emailController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty &&
                                      _seatsController.text.isNotEmpty &&
                                      dropdownvalue != "Select Service") {
                                    if (((int.parse(_seatsController.text)) <=
                                                3 &&
                                            (dropdownvalue == "Daily Rides" ||
                                                dropdownvalue == "Sharing" ||
                                                dropdownvalue ==
                                                    "Intercity")) ||
                                        ((int.parse(_seatsController.text)) >=
                                                3 &&
                                            (int.parse(_seatsController.text)) <
                                                7 &&
                                            (dropdownvalue == "Event" ||
                                                dropdownvalue == "Sharing" ||
                                                dropdownvalue ==
                                                    "Intercity")) ||
                                        ((int.parse(_seatsController.text)) >=
                                                7 &&
                                            (dropdownvalue == "Event" ||
                                                dropdownvalue == "Sharing" ||
                                                dropdownvalue ==
                                                    "Intercity"))) {}
                                    await Database.addDriverDetails(
                                      name: _nameController.text,
                                      phono: _phonenoController.text,
                                      city: _cityController.text,
                                      address: _addressController.text,
                                      services: _servicesController.text,
                                      Email: _emailController.text,
                                      password: _passwordController.text,
                                      latitude: double.parse(latitude!),
                                      longitude: double.parse(longitude!),
                                      seats: int.parse(_seatsController.text),
                                      servicetype: dropdownvalue,
                                      token: devicetoken,
                                    );
                                    //_showMessageInScaffold("Registered Successfully${locationMessage}");
                                    _showMessageInScaffold(
                                        "Registered Successfully");
                                    _register();
                                  } else {
                                    _showMessageInScaffold(
                                        "Please Fill all Fields");
                                  }
                                }
                              },
                              child: Text('SignUp',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )))
              ])),
        ));
  }

  //register void function
  void _register() async {
    print("------------------register enters screen");
    final user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      print("----------------success");
      clearTextInput();

      setState(() {
        _success = true;
        _mechemail = user.email;
      });
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => DriverLoginPage()));
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }
}
