import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelapp/Screens/finish_trip_screen.dart';
import 'package:travelapp/Utils/constants.dart';

class DriverMapPage extends StatefulWidget {
  double originLatitude;
  double originLongitude;
  double destLatitude;
  double destLongitude;
  String? source;
  String? destination;
  String? totalPrice;
  DriverMapPage({
    Key? key,
    this.originLatitude = 0.0,
    this.originLongitude = 0.0,
    this.destLatitude = 0.0,
    this.destLongitude = 0.0,
    this.source,
    this.totalPrice,
    this.destination,
  }) : super(key: key);

  @override
  State<DriverMapPage> createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> _markers = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  bool btntext = true;

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId("sourcePin"),
          position: LatLng(
              widget.originLatitude, widget.originLongitude), //SOURCE_LOCATION,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId("destPin"),
          position: LatLng(widget.destLatitude, widget.destLongitude),
          icon: destinationIcon));
      // _getPolyline();
    });
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), "assets/driving_pin.png");
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        "assets/destination_map_marker.png");
  }

  setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GoogleMapApiKey,
      PointLatLng(widget.originLatitude, widget.originLongitude),
      PointLatLng(widget.destLatitude, widget.destLongitude),
      // travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  @override
  void initState() {
    setSourceAndDestinationIcons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: sizeheight(context),
          width: sizeWidth(context),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(24.8607, 67.0011),
              zoom: 12,
            ),
            onMapCreated: onMapCreated,
            markers: _markers,
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            polylines: Set<Polyline>.of(polylines.values),
          ),
        ),
        /*---------------------------------From box-------------------------------------- */
        addressbox(toppadding: 6.h, title: "From", subtitle: widget.source),
        /*---------------------------------To box-------------------------------------- */
        addressbox(toppadding: 17.h, title: "To", subtitle: widget.destination),
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                "User Name",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "123467892225",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2.h),
              InkWell(
                onTap: () {
                  print("Finish Trip");
                  setState(
                    () {
                      if (btntext) {
                        btntext = false;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FinishTripPage(
                                      from: widget.source,
                                      destination: widget.destination,
                                      totalPrice: widget.totalPrice,
                                    )));
                      } else {
                        btntext = true;
                      }
                    },
                  );
                },
                child: Container(
                  height: 60,
                  width: sizeWidth(context) * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: btntext ? Colors.blueAccent : Colors.redAccent,
                  ),
                  child: Center(
                    child: Text(
                      btntext ? "START TRIP" : "FINISH TRIP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold),
                    ),
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

    setMapPins();
    //_getPolyline();
    setPolylines();
    // if (_originLatitude != 0.0 || _destLongitude != 0.0) {
    //   setPolylines();
    // }
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }
}
