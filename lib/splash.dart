import 'package:belleza/feature/server/helper/s_helpar.dart';
import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_Salon/main_salon_screen.dart';
import 'package:belleza/completeSignUp1.dart';
import 'package:belleza/feature/view/Screen_User/main_user_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:belleza/feature/values/animate_do.dart';
import 'package:get/get.dart';

import 'feature/server/helper/notification_handler.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    configureCallBake();

    var delay = Duration(seconds: 3);
    Future.delayed(delay, () async {
      // getCategory();

      String fcmToken = await _firebaseMessaging.getToken();
      await SHelper.sHelper.addNew("fcmToken", fcmToken);
      ServerUser.serverUser.getCities();
      ServerUser.serverUser.getCategories();
      String token = await SHelper.sHelper.getValue('access_token');
      print(token);
      if (token == null) {
        kNavigatorPushReplacement(context, CompleteSignUp1());
      } else {
        String type = await SHelper.sHelper.getValue("type");
        if (type == "u") {
          ServerUser.serverUser.getAllVaraibles();
          Get.offAll(() => MainUserScreen());
        } else {
          ServerSalon.serverSalon..getAllVaraibles();
          Get.offAll(() => MainSalonScreen());
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JelloIn(
        duration: Duration(milliseconds: 1500),
        animate: true,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void configureCallBake() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        ServerSalon.serverSalon.getMyNotificationSalon();

        NotificationHandler().showNotification(
            message['notification']['title'], message['notification']['body']);
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // NotificationHandler().showNotification(message['title'], message['body']);

        //  _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //   _navigateToItemDetail(message);
      },
    );
  }
}

