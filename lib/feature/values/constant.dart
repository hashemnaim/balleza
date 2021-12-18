
import 'package:belleza/feature/values/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

DateTime currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: 'انقر مرة أخرى للمغادرة');
    return Future.value(false);
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return Future.value(true);
}

setH(double height, BuildContext context) {
  return (height * MediaQuery.of(context).size.height) / 812;
}

setW(double width, BuildContext context) {
  return (width * MediaQuery.of(context).size.width) / 375;
}

setToast(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

BoxDecoration customDecoration1 = BoxDecoration(
  color: AppColors.primaryColor,
  // boxShadow: sShadow2,
  // borderRadius: BorderRadius.circular(10),
  // border: Border.all(
  //   color: Color(0xffEFE0E4),
  // ),
);

BoxDecoration customDecoration2 = BoxDecoration(
  color: Colors.white,
  // boxShadow: sShadow2,
  // borderRadius: BorderRadius.circular(10),
  // border: Border.all(
  //   color: Color(0xffEFE0E4),
 // ),
);
kNavigatorPush(BuildContext context,Widget route ){
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ));
}
kNavigatorPushReplacement(BuildContext context,Widget route ){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ));
}
kNavigatorPushAndRemoveUntil(BuildContext context,Widget route ){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    builder: (context) => route,
  ), (route) => false);
}