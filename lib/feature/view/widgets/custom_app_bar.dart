
import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/Screen_User/more_Screen/notification_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_text.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
 final bool notifications;
 final bool back;

   CustomAppBar({Key key, this.title="",this.notifications=true,this.back=true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:  AppColors.primaryColor,
      title: CustomText(
        text: title,
        color: Colors.white,
      ),
      leading:back? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ):null,
      actions: [
        // GestureDetector(
        //   onTap: () {
        //     // Get.to(() =>MainUserScreen());
        //   },
        //   child: Center(
        //     child: CustomText(
        //       text: "الرئيسية",
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      notifications?  GestureDetector(
              onTap: () async {
                // getNotfcation();
                // await SHelper.sHelper
                //     .setCountNotification(appGet.notification['data'].length);
// appGet.setNotfi(0);
                Get.to(()=>NotificationScreen());
              },
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 30,
                    )),
                  ),
                  Positioned(
                      top: 10,
                      right: 3,
                      child: GetBuilder<AppGetSalon>(
                        init: AppGetSalon(),
                        builder: (controller) => controller.notifiaction.isEmpty
                            ? Container()
                            : CircleAvatar(
                                child: Center(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1.0),
                                  child: CustomText(
                                    text: controller.notifiactionConter.toString(),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                )),
                                backgroundColor: Colors.amber,
                                radius: 10,
                              ),
                      )),
      ],
    )):Container()]);

  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height * 1.2);
}
