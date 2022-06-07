import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelapp/Utils/constants.dart';
import 'package:travelapp/widgets/custome_button.dart';
import 'package:travelapp/widgets/custome_textfield.dart';

class FinishTripPage extends StatelessWidget {
  String? from;
  String? destination;
  String? totalPrice;
  FinishTripPage(
      {Key? key, this.from = "", this.destination = "", this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.grey[800],
        title: new Text(
          "Finish Trip ",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
        toolbarHeight: 70.0,
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            addressbox(title1: from, title2: destination),
            SizedBox(height: 3.h),
            totalPriceBox(totalPrice),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Payment",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            cardBox(context),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomeButton(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Payment Collect Successfully.........."),
                    // duration: Duration(seconds: ),
                  ));
                },
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                text: "Collect Cash",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget totalPriceBox(String? totalprice) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[800],
        ),
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text(
                "${totalprice} PKR",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressbox({
    String? title1,
    String? title2,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[800],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.drive_eta_rounded,
                    color: Colors.white,
                    //size: 32,
                  ),
                  Flexible(
                    child: Text(
                      title1!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    // size: 32,
                  ),
                  Flexible(
                    child: Text(
                      title2!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: sizeWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[800],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Debit Card Number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomeTextFormField(
                hintText: "012 345 8988 2543",
              )
            ],
          ),
        ),
      ),
    );
  }
}
