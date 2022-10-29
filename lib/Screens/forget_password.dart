import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelapp/Screens/login_user_screen.dart';
import 'package:travelapp/Utils/constants.dart';
import 'package:travelapp/services/database_helper.dart';

//import 'package:meconline/HomePage.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  //snackbar message
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
    ));
  }
  var sec = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  String? _email, _password, _name;

  // ignore: non_constant_identifier_names
  SignUp(String email, String password) async {
    // _formKey.currentState.save();
    print(email + "Chec email");
    print(password + "cech password");
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        print("Sucess");
        _showMessageInScaffold("Registered Successfully");
        clearTextInput();
        new Future.delayed(const Duration(seconds: 5), () {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     builder: (BuildContext context) => LoginPage()
          //   )
          // );
        });
        // Navigator.of(context)
        //     .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
      }
    } catch (e) {
      throw e;
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errormessage),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  //clear controller
  clearTextInput() {
    email.clear();
    password.clear();
    name.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('$imgpath/carbackground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Container(
                height: sizeheight(context),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: sizeheight(context) * 0.20),
                        child: Text("Forget Password",
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                      ),
                      SizedBox(height: sizeheight(context) * 0.15),
                      Container(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  
                                  Container(
                                    child: TextFormField(
                                        // ignore: missing_return
                                         validator: (input) {
                                       if (input ==null ) 
                                            return 'Enter Email';
                                         },
                                        controller: email,
                                        decoration: InputDecoration(
                                            labelText: 'Email',
                                            prefixIcon: Icon(Icons.email)),
                                        onSaved: (input) => _email = input),
                                  ),

                                  
                                  SizedBox(height: 30),
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    padding:
                                        EdgeInsets.fromLTRB(70, 10, 70, 10),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (email.text.isNotEmpty) {
                                          // showDialog(
                                          //   context: context, 
                                          //   builder: (context) => Center(
                                          //     child: CircularProgressIndicator(),
                                          //   ));
                                            try {
                                          await FirebaseAuth.instance
                                            .sendPasswordResetEmail(email: email.text.trim())
                                            .then((value) => Fluttertoast.showToast(
                                              msg: "Passwrod Reset Email Sent",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 5,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                            ));
                                            Navigator.of(context).pop();
                                            }
                                            on FirebaseAuthException catch (e) {
                                              print(e);
                                              _showMessageInScaffold(
                                              "Please enter valid email");
                                            }
                                        } else {
                                          print("------------");
                                          _showMessageInScaffold(
                                              "Please enter valid email");
                                        }
                                      }
                                    },
                                    child: Text('Reset Password',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                    color: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  )
                                ],
                              )))
                    ])),
          )),
    );
  }
}
