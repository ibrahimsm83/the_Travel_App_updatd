import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelapp/Screens/splash_screen.dart';
import 'blocs/application_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'home.dart';
import 'bottomnav.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

import 'services/local_push_notification.dart';

// Future<void> _handlebackgroundMessaging(RemoteMessage message) async {
//   /// Onclick listener
// }
Future<void> backgroundHandler(RemoteMessage message) async {
  	print(message.data.toString());
 	print(message.notification!.title);
	}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        //localizationsDelegates: localizationsDelegates,
      ),
    );
  }
  
}

// class InitializerWidget extends StatefulWidget {
//   @override
//   _InitializerWidgetState createState() => _InitializerWidgetState();
// }

// class _InitializerWidgetState extends State<InitializerWidget> {
//   late FirebaseAuth _auth;

//   late User _user;

//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _auth = FirebaseAuth.instance;
//    // _user = _auth.currentUser?? ;
//     isLoading = false;
//   }

//   @override
//   Widget build(BuildContext context) {

//     return isLoading
//         ? Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           )
//         //: _user == null
//            // ? LoginScreen()
//             : BottomNav();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Polyline example',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.orange,
//       ),
//       home: MapScreen(),
//     );
//   }
// }

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
//   // double _destLatitude = 6.849660, _destLongitude = 3.648190;
//   // double _originLatitude = 26.48424, _originLongitude = 50.04551;
//   // double _destLatitude = 26.46423, _destLongitude = 50.06358;
//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPiKey = "AIzaSyAqIKT2h4a3aR1_IETd7vXQWD0fzDLdbsg";
  

//   @override
//   void initState() {
//     super.initState();

//     // /// origin marker
//     // _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
//     //     BitmapDescriptor.defaultMarker);

//     // /// destination marker
//     // _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
//     //     BitmapDescriptor.defaultMarkerWithHue(90));
//     _getPolyline();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//             target: LatLng( 24.860966, 66.990501), zoom: 15),
//         myLocationEnabled: true,
//         tiltGesturesEnabled: true,
//         compassEnabled: true,
//         scrollGesturesEnabled: true,
//         zoomGesturesEnabled: true,
//         onMapCreated: _onMapCreated,
//         markers: Set<Marker>.of(markers.values),
//         polylines: Set<Polyline>.of(polylines.values),
//       )),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) async {
//     mapController = controller;
//   }

//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//         Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }

//   _addPolyLine() {
//     print("add polilines----------");
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id, color: Colors.red, points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   _getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//        // PointLatLng(_originLatitude, _originLongitude),
//        PointLatLng(24.860966, 66.990501),
//        // PointLatLng(_destLatitude, _destLongitude),
//          PointLatLng(31.582045, 74.329376),

//        // travelMode: TravelMode.driving,
//        // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
//         );
//         print("----------result points----------");
//         print(result.points);
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//     _addPolyLine();
//   }
// }