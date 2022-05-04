import 'package:flutter/material.dart';
import 'package:travelapp/bottomnav.dart';

// ignore: must_be_immutable
class BookedRide extends StatefulWidget {
  String pick;
  String drop;
  BookedRide ({ Key? key,required this.pick,required this.drop}) : super(key: key);

  @override
  _BookedRideState createState() => _BookedRideState();
}

class _BookedRideState extends State<BookedRide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF21BFBD),
      backgroundColor: Colors.grey[800],
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BottomNav()));
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Row(
                children: [
                  Text(
                    "Ride Confirmed",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  )
                ],
              )),
          SizedBox(height: 20.0),
          Container(
              height: MediaQuery.of(context).size.height - 135.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 20.0, right: 20.0),
                      child: Text(
                        "Your Ride has been confirmed",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Text(
                        "From",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Text(
                        widget.pick,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ),

                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Text(
                        "To",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Text(
                        widget.drop,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
