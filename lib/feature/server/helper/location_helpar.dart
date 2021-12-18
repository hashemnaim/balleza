// import 'package:geolocator/geolocator.dart';

// class Location {
//   Location._();
//   static final Location location = Location._();
//   Position currentPosition;
//   String name;
//   String phoneNum;
//   Geolocator geolocator;

//   Future<Geolocator> initGeolocator() async {
//     if (geolocator == null) {
//       geolocator = Geolocator();
//       return geolocator;
//     } else {
//       return geolocator;
//     }
//   }

//  Future<Position> getCurrentLocation2() async {
//                        print("position.longitude");

//     Position position =await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//                       print(position.longitude);

//     return position;
//   }
//   Future getCurrentLocation() async {
//                 print("position.longitude");

//     geolocator = await initGeolocator();
//                     print("position.longitude");
// Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//     // await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
//     //                       print("position.longitude");

//     //   this.currentPosition = position;
//     //         print(position.longitude);

//     //   return currentPosition;
//     // }).catchError((e) {
//     //   print(e);
//     // });
//   }

//   // getAddressFromLatLng() async {
//   //   try {
//   //     geolocator =await initGeolocator();
//   //     List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);

//   //     Placemark place = placemarks[0];
//   //       currentAddress ="${place.locality}, ${place.administrativeArea}, ${place.subLocality}";

//   //       return currentAddress ;
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

// }
