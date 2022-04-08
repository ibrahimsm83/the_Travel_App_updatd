

import 'package:flutter/material.dart';
import 'package:travelapp/Screens/bookedride.dart';
import 'package:travelapp/Utils/constants.dart';

class DropOffListPg extends StatefulWidget {
  final List? addresslist;
  String pickup;
  DropOffListPg({ Key? key,this.addresslist,required this.pickup }) : super(key: key);

  @override
   DropOffListPgState createState() =>  DropOffListPgState();
}

class  DropOffListPgState extends State<DropOffListPg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar:AppBar(leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: const Text(
              "Drop Off Locations",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            backgroundColor: Colors.grey[800],
            toolbarHeight: 70.0,
          ),
      body: ListView.builder(
        itemCount: widget.addresslist!.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              print( widget.addresslist![index]);
               Navigator.push(
                 context, 
                 MaterialPageRoute(
                   builder: (context) => BookedRide(
                     pick: widget.pickup,
                     drop: widget.addresslist![index]
                    )
                  )
                );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 70,
                width:MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.addresslist![index],
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 17.0
                  ),
                  ),
              ),
              ),
            ),
          );
        },
       
      ),
    );
  }
}