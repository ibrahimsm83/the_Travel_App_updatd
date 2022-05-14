import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelapp/Utils/constants.dart';

class DriverMapPage extends StatefulWidget {
  double originLatitude;
  double originLongitude;
  double destLatitude;
  double destLongitude;
  DriverMapPage(
      {Key? key,
      this.originLatitude = 0.0,
      this.originLongitude = 0.0,
      this.destLatitude = 0.0,
      this.destLongitude = 0.0})
      : super(key: key);

  @override
  State<DriverMapPage> createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: sizeheight(context),
          width: sizeWidth(context),
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(24.8607, 67.0011), zoom: 12),
            onMapCreated: onMapCreated,
          ),
        ),
        /*---------------------------------From box-------------------------------------- */
        addressbox(
            toppadding: 6.h,
            title: "From",
            subtitle: "From dfsjasd fksadf;ksadfs sdff d"),
        /*---------------------------------To box-------------------------------------- */
        addressbox(
            toppadding: 17.h,
            title: "To",
            subtitle:
                "Destination dfsjasd fksadf;ksadfs sdff ds fas ;dfs k;asj flk;sa dfaslkdfj ;"),
        /*---------------------------------User box-------------------------------------- */
        userinfoBox(),
        SizedBox(
          height: 10.0,
        )
      ]),
    );
  }

  Widget userinfoBox() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: sizeWidth(context) * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: text_Color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "User Detail",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Text(
                "Muhammad ibraheem",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Text(
                "123467892225",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 60,
                width: sizeWidth(context) * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.blueAccent,
                ),
                child: Center(
                  child: Text(
                    "START TRIP",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget addressbox({
    double? toppadding,
    String? title,
    String? subtitle,
  }) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: toppadding!,
          left: 5.w,
          right: 5.w,
        ),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: text_Color,
            ),
            child: ListTile(
              leading: Icon(
                Icons.location_city,
                size: 32,
              ),
              title: Text(
                title!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
              ),
            )),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    // setMapPins();
    // _getPolyline();
    // if (_originLatitude != 0.0 || _destLongitude != 0.0) {
    //   setPolylines();
    // }
  }
}
