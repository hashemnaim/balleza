
import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/custom_nav_bottom.dart';
import 'package:belleza/feature/view/Screen_Salon/home_Screen/salon_reservations_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_Screen/salon_more_screen.dart';
import 'home_Screen/salon_servece_screen.dart';


class MainSalonScreen extends StatefulWidget {

  @override
  _MainUserScreenState createState() => _MainUserScreenState();
}

class _MainUserScreenState extends State<MainSalonScreen> {
@override
void initState() { 
  super.initState();

}
final List<Widget> widgetOptions = <Widget>[
    SalonReservationsScreen(),
    SalonHomeScreen(),
    ProfileSalonScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // endDrawer: DrawerCustom(),
        body: GetBuilder<AppGetSalon>(
          init: AppGetSalon(),
          builder: (controller) {

            return widgetOptions[controller.indexNav];
          },
        ),
        bottomNavigationBar: CustomNavSaloneBottom());
  }
}
