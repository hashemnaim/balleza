import 'package:belleza/feature/server/app_get_cart.dart';
import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/helper/s_helpar.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/view/Screen_Salon/home_Screen/salon_notification_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/MarketScreen.dart/cart_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/search_screen.dart';
import 'package:belleza/feature/view/Screen_User/more_Screen/notification_user_screen.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/maps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:get/get.dart';

import '../../../map.dart';

class TopUserScreen extends StatelessWidget {
  final String title;
  final bool searchWidget;
  final bool back;
  final bool nofiction;
  final bool cart;
  final double height;

  TopUserScreen(
      {this.title,
      this.searchWidget = false,
      this.back = false,
      this.height,
      this.nofiction = true,
      this.cart = true});
  final AppGetUser appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
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
                              text: title,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xffEFE0E4))
                        ],
                      ),
                    ),
                    nofiction
                        ? GestureDetector(
                            onTap: () async {
                              ServerUser.serverUser.getMyNotification();
                              await SHelper.sHelper.setCountNotification(
                                  appGet.notifiaction['data'].length);
                              Get.to(() => NotificationScreen());
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
                                    top: 6,
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
                        : Container(),
                    cart
                        ? GestureDetector(
                            onTap: () {
                              Get.to(() => CartScreen());
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Icon(
                                    Icons.shopping_bag,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                                ),
                                Positioned(
                                    top: 6,
                                    left: 3,
                                    child: GetBuilder<GetCart>(
                                      init: GetCart(),
                                      builder: (controller) => controller
                                              .cartProductModel.isEmpty
                                          ? Container()
                                          : CircleAvatar(
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1.0),
                                                child: CustomText(
                                                  text: controller
                                                      .cartProductModel.length
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
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(()=>MapsG("31.5", "34.46667"));
                      },
                        child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 30,
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SvgPicture.asset(
                    'assets/svg/logoWhite.svg',
                    color: Colors.white.withOpacity(0.5),
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: searchWidget,
            child: Positioned(
              bottom: -28,
              child: GestureDetector(
                onTap: () async {
                  Get.to(() => SearchScreen());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SizedBox(
                    height: 45.h,
                    width: 313.w,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: sShadow1,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "search".tr,
                              style: TextStyle(color: Colors.grey),
                            ),
                            // Container(),
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
          ),
        ],
      ),
    );
  }
}
