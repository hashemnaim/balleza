import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/view/widgets/custom_nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_Screen/MarketScreen.dart/market_screen.dart';
import 'home_Screen/home_screen.dart';
import 'more_Screen/more_screen.dart';
import 'home_Screen/reservations_screen.dart';

class MainUserScreen extends StatefulWidget {
  @override
  _MainUserScreenState createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainUserScreen> {
  @override
  void initState() {
    super.initState();
  }

  static List<Widget> widgetOptions = <Widget>[
    Home(),
    ReservationsScreen(),
    MarketScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // endDrawer: DrawerCustom(),
        body: GetBuilder<AppGetUser>(
          init: AppGetUser(),
          builder: (controller) {
            return widgetOptions[controller.indexNav];
          },
        ),
        bottomNavigationBar: CustomNavBottom()
        );
  }
}
