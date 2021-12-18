import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_Item_nav_bottom.dart';

class CustomNavSaloneBottom extends StatelessWidget {
  final bool internalScreen;
  CustomNavSaloneBottom({this.internalScreen = false});
  final AppGetSalon controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CustomBottomAppBar(
        onTabSelected: (index) async {
          // Get.offAll(MainUserScreen());

          GetBuilder<AppGetSalon>(
              init: AppGetSalon(),
              builder: (control) {
                return control.setindexNav(index);
              });
        },
        items: [
          CustomAppBarItem(icon: Icons.list_alt, titel: "Reservations".tr),
          CustomAppBarItem(icon: Icons.shopping_cart, titel: "services".tr),
          CustomAppBarItem(icon: Icons.person, titel: "more".tr),
        ]);
  }
}
