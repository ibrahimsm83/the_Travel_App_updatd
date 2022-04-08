import 'package:flutter/material.dart';
import 'package:travelapp/Screens/dropoff_list_screen.dart';
import 'package:travelapp/Utils/constants.dart';

class PickupListPg extends StatefulWidget {
  final List? addresslist;
  final List? dropofflist;
  const PickupListPg({ Key? key,this.addresslist,this.dropofflist }) : super(key: key);

  @override
  _PickupListPgState createState() => _PickupListPgState();
}

class _PickupListPgState extends State<PickupListPg> {
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
              "Pickup Locations",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                )),
            backgroundColor: Colors.grey[800],
            toolbarHeight: 70.0,),
      body: ListView.builder(
        itemCount: widget.addresslist!.length,
        itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              print( widget.addresslist![index]);
               Navigator.push(
                 context, 
                 MaterialPageRoute(
                   builder: (context) => DropOffListPg(
                     addresslist: widget.dropofflist,
                     pickup: widget.addresslist![index]
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

