import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_app_bar.dart';

class MapsG extends StatefulWidget {
  final String locationLat;
  final String locationLong;
  MapsG(this.locationLat, this.locationLong);
  @override
  State<StatefulWidget> createState() {
    return LocationCollecterState();
  }
}

class LocationCollecterState extends State<MapsG> {
  GoogleMapController mapController;
  // GlobalKey<ScaffoldState> scaffolState = GlobalKey();
  String label = '';
  String adrees = "";
  AppGetUser controller = Get.find();
//  final LatLng _center = const LatLng(24.4539, 54.3773);

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));
    return position;
  }

  animateCamera(LatLng location) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 8),
      ),
    );
    //  setState(() {});
  }
  //  getCurrentLocation() async {
  //   try {
  //     Geo.Position position = await Geo.Geolocator.getCurrentPosition(
  //       desiredAccuracy: Geo.LocationAccuracy.high,
  //     );
  //     LatLng myLocation = LatLng(position.latitude, position.longitude);
  //     // _markers2.add(Marker(
  //     //   markerId: MarkerId("MyLocation"),
  //     //   position: myLocation,
  //     // ));
  //     mapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: myLocation, zoom: 14),
  //       ),
  //     );
  //     lat = position.latitude;
  //     long = position.longitude;

  //     setState(() {});
  //   } catch (e) {}
  // }
  void _onMapCreated(GoogleMapController control) {
    mapController = control;
    getCurrentLocation().then((position) {
      markerPosition = position;
      _markers.clear();
      _markers.add(Marker(
          markerId: MarkerId('userSelection'),
          position: LatLng(double.parse(widget.locationLat),
              double.parse(widget.locationLong))));
      setState(() {});
    });
    animateCamera(LatLng(
        double.parse(widget.locationLat), double.parse(widget.locationLong)));
  }

  Future<String> getLoction(LatLng postion) async {
    try {
      List<Address> address = await Geocoder.local.findAddressesFromCoordinates(
          Coordinates(postion.latitude, postion.longitude));
      print("address[1].countryName");

      print(address[1].countryName);
      adrees = address[1].countryName;
      return adrees;
    } catch (e) {
      print("00000$e");
    }
    setState(() {});
  }

  Set<Marker> _markers = {};

  Position markerPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.h),
        child: CustomAppBar(
          title: "الصالونات القريبة منك  ",
        ),
      ),
      //key: scaffolState;

      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        markers: {
          Marker(
              markerId: MarkerId('userSelection+${markerPosition.longitude}'),
              position:LatLng(markerPosition.latitude, markerPosition.longitude))
        },
        onTap: (piclerLocation) {
          // _markers.clear();
          _markers.add(Marker(
              markerId: MarkerId('userSelection+${markerPosition.longitude}'),
              position:
                  LatLng(piclerLocation.latitude, piclerLocation.longitude)));
          markerPosition = Position(
              latitude: piclerLocation.latitude,
              longitude: piclerLocation.longitude);
          setState(() {});
        },
        onMapCreated: (GoogleMapController controller) async {
          mapController = controller;
          // await getCurrentLocation();
          // await getLoca(providerObject);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.locationLat),
              double.parse(widget.locationLong)),
          zoom: 10,
        ),
      ),
    );
  }
}
