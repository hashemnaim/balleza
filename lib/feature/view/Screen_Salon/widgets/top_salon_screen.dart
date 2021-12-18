import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/helper/s_helpar.dart';
import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/view/Screen_Salon/home_Screen/salon_notification_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/search_screen.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:get/get.dart';

class TopSalonScreen extends StatelessWidget {
  final String title;
  final bool searchWidget;
  final bool back;
  final bool nofiction;
  final bool cart;
  final double height;

  TopSalonScreen(
      {this.title,
      this.searchWidget = false,
      this.back = false,
      this.height,
      this.nofiction = true,
      this.cart = true});
  final AppGetSalon appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          // height: height,
          width: double.infinity,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        back
                            ? IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            : Container(),
                        CustomText(
                            text: title.tr,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w300,
                            color: Color(0xffEFE0E4))
                      ],
                    ),
                  ),
                  nofiction
                      ? GestureDetector(
                          onTap: () async {
                          ServerSalon.serverSalon.getMyNotificationSalon();
                            // await SHelper.sHelper
                            //     .setCountNotification(appGet.notification['data'].length);
// appGet.setNotfi(0);
                            await SHelper.sHelper.setCountNotification(
                                appGet.notifiaction['data'].length);

                            Get.to(() => NotificationSalonScreen());
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
                                  top: 2,
                                  left: 2,
                                  child: GetBuilder<AppGetSalon>(
                                    init: AppGetSalon(),
                                    builder: (controller) => controller
                                            .notifiaction.isEmpty
                                        ? Container()
                                        : CircleAvatar(
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 1.0),
                                              child: CustomText(
                                                text: controller
                                                    .notifiactionConter
                                                    .toString(),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            )),
                                            backgroundColor: Colors.amber,
                                            radius: 10,
                                          ),
                                  )),
                            ],
                          ))
                      : Container()
                ],
              ),
              SvgPicture.asset(
                'assets/svg/logoWhite.svg',
                color: Colors.white.withOpacity(0.5),
                height: 90.h,
                width: 90.w,
              ),
            ],
          ),
        ),
        Visibility(
          visible: searchWidget,
          child: Positioned(
            bottom: -25,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => SearchScreen());
                },
                child: Container(
                  height: 45.h,
                  width: 313.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: sShadow1,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "search".tr,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/svg/search.svg',
                          height: 27.h,
                          width: 27.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
