import 'package:belleza/feature/server/app_get_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'custom_Item_nav_bottom.dart';

class CustomNavBottom extends StatelessWidget {
final  bool internalScreen;
  CustomNavBottom({this.internalScreen = false});

  @override
  Widget build(BuildContext context) {
    return CustomBottomAppBar(
        onTabSelected: (index) async {
          // Get.offAll(MainUserScreen());

          GetBuilder<AppGetUser>(
            init:AppGetUser(),
            builder: (control) {
            return control.setindexNav(index);
          });
        },
        items: [
          CustomAppBarItem(icon: Icons.home, titel: "main".tr),
          CustomAppBarItem(icon: Icons.list_alt, titel: "Reservations".tr),
          CustomAppBarItem(icon: Icons.shopping_bag, titel: "shop".tr),
          CustomAppBarItem(icon: Icons.person, titel: "more".tr),
        ]);
  }
}
