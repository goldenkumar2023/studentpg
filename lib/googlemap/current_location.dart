import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCurrent extends StatefulWidget {
  const MapCurrent({super.key});

  @override
  State<MapCurrent> createState() => _MapCurrentState();
}

class _MapCurrentState extends State<MapCurrent> {

  String _locationMessage = '';

  String? country;
  String? loc;
  String? post;
  String? sub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(country ?? ""),
          Text(loc ?? ""),
          Text(post ?? ""),
          Text(sub ?? ""),
          Text(country ?? ""),
          Text(sub ?? ""),
        ],
      )
      ,
      floatingActionButton: FloatingActionButton(onPressed: () {
        _requestLocationPermission();
      },),
    );
  }

  Future<void> _requestLocationPermission() async {
    final permissionStatus = await Geolocator.requestPermission();
    if (permissionStatus == LocationPermission.denied) {
      setState(() {
        Fluttertoast.showToast(
          msg: "please give permission to the location",
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM,
          // Toast position
          timeInSecForIosWeb: 1,
          // Time duration for iOS/web
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } else if (permissionStatus == LocationPermission.always ||
        permissionStatus == LocationPermission.whileInUse) {
      setState(() {
        _getLocation();
      });
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );


      if (placemarks.isNotEmpty) {
        if (placemarks.first.locality != null) {
          country = placemarks.first.country;
          loc = placemarks.first.locality;
          post = placemarks.first.subLocality;
          sub = placemarks.first.postalCode;
          country = placemarks.first.street;
        }
      }
      LatLng _currentPosition;
      setState(() {
        _locationMessage =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        Fluttertoast.showToast(
          msg: position.latitude.toString(),
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM,
          // Toast position
          timeInSecForIosWeb: 1,
          // Time duration for iOS/web
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
        Fluttertoast.showToast(
          msg: _locationMessage,
          toastLength: Toast.LENGTH_SHORT,
          // or Toast.LENGTH_LONG
          gravity: ToastGravity.BOTTOM,
          // Toast position
          timeInSecForIosWeb: 1,
          // Time duration for iOS/web
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    }
  }


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class Currentlocation extends StatefulWidget {
//   const Currentlocation({Key? key}) : super(key: key);
//
//   @override
//   State<Currentlocation> createState() => _CurrentlocationState();
// }
//
// class _CurrentlocationState extends State<Currentlocation> {
//
//   GoogleMapController? mapController;
//   LocationData? currentLocation;
//
//   @override
//
//   void initState() {
//     super.initState();
//     initializeLocation();
//   }
//
//   void initializeLocation() async {
//     Location location = Location();
//     bool _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     PermissionStatus _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     LocationData locationData = await location.getLocation();
//     setState(() {
//       currentLocation = locationData;
//     });
//   }
//   @override
//
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Current Location'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (currentLocation != null)
//               Text(
//                 'Latitude: ${currentLocation!.latitude}\nLongitude: ${currentLocation!.longitude}',
//                 textAlign: TextAlign.center,
//               ),
//             SizedBox(height: 20),
//             if (currentLocation != null)
//               Container(
//                 height: 300,
//                 width: double.infinity,
//                 child: GoogleMap(
//                   onMapCreated: (controller) {
//                     setState(() {
//                       mapController = controller;
//                     });
//                   },
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(
//                       currentLocation!.latitude!,
//                       currentLocation!.longitude!,
//                     ),
//                     zoom: 15,
//                   ),
//                   markers: Set<Marker>.from([
//                     Marker(
//                       markerId: MarkerId('currentLocation'),
//                       position: LatLng(
//                         currentLocation!.latitude!,
//                         currentLocation!.longitude!,
//                       ),
//                     ),
//                   ]),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
}
