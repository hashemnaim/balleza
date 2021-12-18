import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/utils_Language/translation.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:get/get.dart';
import 'feature/server/app_get_salon.dart';
import 'feature/server/app_get_cart.dart';
import 'feature/server/helper/notification_handler.dart';
import 'feature/server/helper/s_helpar.dart';
import 'splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  String lang = await SHelper.sHelper.getValue("Lang");

  Get.lazyPut(() => AppGetUser(), fenix: true);
  Get.lazyPut(() => AppGetSalon(), fenix: true);
  Get.lazyPut(() => GetCart(), fenix: true);
  NotificationHandler().initialization();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // navigation bar color
      statusBarColor: Colors.transparent,
      // systemNavigationBarColor: AppColors.primaryColor,
      systemNavigationBarIconBrightness: Brightness.light
      // status bar color
      ));
  runApp(MyApp(lang));
}

class MyApp extends StatelessWidget {
  final String lang;
  MyApp(this.lang);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: _initialization,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ScreenUtilInit(
          designSize: Size(375, 812),
          allowFontScaling: true,
          builder: () {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: Translation(),
              locale: Locale(lang ?? "en"),
              fallbackLocale: Locale(lang ?? "en"),
              home: Splash(),
            );
          },
        );
      },
    );
  }
}
