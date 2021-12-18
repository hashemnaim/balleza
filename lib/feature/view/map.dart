// import 'dart:io';

// import 'package:belleza/feature/server/app_get_salon.dart';
// import 'package:belleza/feature/values/colors.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geolocator/geolocator.dart' as Geo;
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// import 'widgets/custom_app_bar.dart';

// class InfoWindowModel extends ChangeNotifier {
//   bool _showInfoWindow = false;
//   bool _tempHidden = false;
//   Map _user;
//   double _leftMargin;
//   double _topMargin;

//   void rebuildInfoWindow() {
//     notifyListeners();
//   }

//   void updateUser(Map user) {
//     _user = user;
//     notifyListeners();
//   }

//   void updateVisibility(bool visibility) {
//     _showInfoWindow = visibility;
//   }

//   void updateInfoWindow(
//     BuildContext context,
//     GoogleMapController controller,
//     LatLng location,
//     double infoWindowWidth,
//     double markerOffset,
//   ) async {
//     ScreenCoordinate screenCoordinate =
//         await controller.getScreenCoordinate(location);
//     double devicePixelRatio =
//         Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
//     double left = (screenCoordinate.x.toDouble() / devicePixelRatio) -
//         (infoWindowWidth / 2);
//     double top =
//         (screenCoordinate.y.toDouble() / devicePixelRatio) - markerOffset;
//     if (left < 0 || top < 0) {
//       _tempHidden = true;
//     } else {
//       _tempHidden = false;
//       _leftMargin = left;
//       _topMargin = top;
//     }
//   }

//   bool get showInfoWindow =>
//       (_showInfoWindow == true && _tempHidden == false) ? true : false;

//   double get leftMargin => _leftMargin;

//   double get topMargin => _topMargin;

//   Map get user => _user;
// }

// class CustomInfoWindow extends StatefulWidget {
//   @override
//   _CustomInfoWindowState createState() => _CustomInfoWindowState();
// }

// class _CustomInfoWindowState extends State<CustomInfoWindow> {
//   GoogleMapController mapController;

//   AppGetSalon apiGet = Get.find();
//   LatLng _center = LatLng(31.5, 34.46667);
//   final double _zoom = 15.0;
//   BitmapDescriptor currentIcon;
//   double lat = 0;

//   double long = 0;
//   bool typeMap = false;
//   double distanc = 0;

//   setTypeMap() {
//     typeMap = !typeMap;
//     setState(() {});
//   }

//   // getCustomIcon() async {
//   //   BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(
//   //       ImageConfiguration.empty, "assets/images/mapicon.png");
//   //   currentIcon = bitmapDescriptor;
//   //   setState(() {});
//   // }

//   Set<Marker> _markers2 = Set<Marker>();

//   getLoca(var providerObject) async {
//     // try {
//     Map user = apiGet.nearOsra;
//     for (var i = 0; i < user['osraproduct'].length; i++) {
//       var now = DateTime.now().millisecondsSinceEpoch;
//       _markers2.add(Marker(
//         markerId: MarkerId(
//             user['osraproduct'][i]['name'].toString() + now.toString()),
//         position: LatLng(double.parse(user['osraproduct'][i]['latitude']),
//             double.parse(user['osraproduct'][i]['longitude'])),
//         icon: currentIcon,
//         onTap: () {
//           providerObject.updateInfoWindow(
//             context,
//             mapController,
//             LatLng(double.parse(user['osraproduct'][i]['latitude']),
//                 double.parse(user['osraproduct'][i]['longitude'])),
//             _infoWindowWidth,
//             _markerOffset,
//           );
//           providerObject.updateUser(user['osraproduct'][i]);
//           providerObject.updateVisibility(true);
//           providerObject.rebuildInfoWindow();

//           // distanc = distanceBetwineLocation(
//           //     lat, long, user.data[i].lat, user.data[i].long);
//           setState(() {});
//         },
//         // icon: currentIcon,
//       ));
//     }
//     setState(() {});
//     // } catch (e) {}
//   }

//   getCurrentLocation() async {
//     try {
//       Geo.Position position = await Geo.Geolocator.getCurrentPosition(
//         desiredAccuracy: Geo.LocationAccuracy.high,
//       );
//       LatLng myLocation = LatLng(position.latitude, position.longitude);
//       // _markers2.add(Marker(
//       //   markerId: MarkerId("MyLocation"),
//       //   position: myLocation,
//       // ));
//       mapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: myLocation, zoom: 14),
//         ),
//       );
//       lat = position.latitude;
//       long = position.longitude;

//       setState(() {});
//     } catch (e) {}
//   }

//   final double _infoWindowWidth = 250;
//   final double _markerOffset = 170;
//   @override
//   void initState() {
//     super.initState();
//     // getCustomIcon();
//     getCurrentLocation();
//   }

//   // distanceBetwineLocation(
//   //   double startCoordinatesLat,
//   //   double startCoordinatesLong,
//   //   double endCoordinatesLat,
//   //   double endCoordinatesLong,
//   // ) {
//   //   double distanceInMeters = Geo.Geolocator.distanceBetween(
//   //       startCoordinatesLat,
//   //       startCoordinatesLong,
//   //       endCoordinatesLat,
//   //       endCoordinatesLong);
//   //   return distanceInMeters;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // final providerObject = Provider.of<InfoWindowModel>(context, listen: false);

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size(double.infinity, 50.h),
//         child: CustomAppBar(
//           title: "الأسر القريبة منك  ",
//         ),
//       ),
//       body: Container(
//         child: Consumer<InfoWindowModel>(
//           builder: (context, model, child) {
//             return Stack(
//               children: <Widget>[
//                 child,
//                 Positioned(
//                   left: 0,
//                   top: 0,
//                   child: Visibility(
//                     visible: providerObject.showInfoWindow,
//                     child: (providerObject.user == null ||
//                             !providerObject.showInfoWindow)
//                         ? Container()
//                         : Container(
//                             margin: EdgeInsets.only(
//                               left: providerObject.leftMargin,
//                               top: providerObject.topMargin,
//                             ),
//                             // Custom InfoWindow Widget starts here
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: Colors.white,
//                               ),
//                               height: 155,
//                               width: 250,
//                               padding: EdgeInsets.all(15),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text('${providerObject.user['name']}'),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       providerObject.user['image'] == null
//                                           ? Container(
//                                               width: 45,
//                                               height: 45,
//                                               decoration: BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 color: AppColors.primaryColor,
//                                               ),
//                                             )
//                                           : CachedNetworkImage(
//                                               imageUrl:
//                                                   providerObject.user['image'],
//                                               imageBuilder:
//                                                   (context, imageProvider) =>
//                                                       Container(
//                                                 width: 45,
//                                                 height: 45,
//                                                 decoration: BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   image: DecorationImage(
//                                                     image: imageProvider,
//                                                     fit: BoxFit.fill,
//                                                   ),
//                                                 ),
//                                               ),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                       Icon(Icons.error),
//                                             ),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         "${(providerObject.user['distance']).toStringAsFixed(2)} كم",
//                                         // '${((Geolocator.distanceBetween(double.parse(apiGet.profileMap['user']['latitude']), double.parse(apiGet.profileMap['user']['longitude']), double.parse(providerObject.user['latitude']), double.parse(providerObject.user['longitude'])))/1000).toStringAsFixed(2)}',
//                                         // style: getStyle(
//                                         //     blackColor, FontWeight.normal, 18),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Icon(
//                                         FontAwesomeIcons.mapMarkerAlt,
//                                         color: AppColors.primaryColor,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: ScreenUtil().setHeight(2),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       // apiGet.osraproductMap.assignAll({});
//                                       // Server.server.getosraproduct(
//                                       //     providerObject.user['user_id']
//                                       //         .toString(),
//                                       //     '0');

//                                       // Get.to(FamilyScreen(providerObject.user));
//                                     },
//                                     child: Container(
//                                       width: double.infinity,
//                                       height: ScreenUtil().setHeight(35),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.primaryColor,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'عرض صفحة الأسرة',
//                                           style: GoogleFonts.cairo(
//                                             textStyle: TextStyle(
//                                               fontSize: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             // Custom InfoWindow Widget ends here
//                           ),
//                   ),
//                 ),
//               ],
//             );
//           },
//           child: Positioned(
//             child: GoogleMap(
//               myLocationEnabled: true,
//               mapType: typeMap == false ? MapType.normal : MapType.hybrid,
//               onTap: (position) {
//                 if (providerObject.showInfoWindow) {
//                   providerObject.updateVisibility(false);
//                   providerObject.rebuildInfoWindow();
//                 }
//               },
//               onCameraMove: (position) {
//                 if (providerObject.user != null) {
//                   providerObject.updateInfoWindow(
//                     context,
//                     mapController,
//                     LatLng(double.parse(providerObject.user['latitude']),
//                         double.parse(providerObject.user['longitude'])),
//                     _infoWindowWidth,
//                     _markerOffset,
//                   );
//                   providerObject.rebuildInfoWindow();
//                 }
//               },
//               onMapCreated: (GoogleMapController controller) async {
//                 mapController = controller;
//                 await getCurrentLocation();
//                 await getLoca(providerObject);
//               },
//               markers: _markers2,
//               initialCameraPosition: CameraPosition(
//                 target: _center,
//                 zoom: _zoom,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
