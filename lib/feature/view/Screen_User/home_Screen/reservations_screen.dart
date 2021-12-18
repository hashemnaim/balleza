import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/top_user_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/user_reservation_item.dart';
import 'package:belleza/feature/view/widgets/custom_rate.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ReservationsScreen extends StatefulWidget {
  @override
  _SalonReservationsScreenState createState() =>
      _SalonReservationsScreenState();
}

class _SalonReservationsScreenState extends State<ReservationsScreen> {
  AppGetUser appGet = Get.find();
  bool stats = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
          child: Scaffold(
        body: Obx(
            () => Directionality(
              textDirection: TextDirection.rtl,
                          child: Column(
                children: [
                  TopUserScreen(
                    title: 'Reservations'.tr,
                    searchWidget: false,
                    // height: 120.h,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      // height: 45.h,
                      child: Row(
          children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (stats == true) {
                  stats = !stats;
                  print(stats);
                  setState(() {});
                    } else {
                  stats = stats;
                  print(stats);
                    }
                  },
                  child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    color:
          stats ? AppColors.kPink2 : AppColors.pinkDark,
                  ),
                  child: CustomText(
                      text: 'Upcoming reservations'.tr,
                      color:
              stats ? AppColors.pinkDark : Colors.white)),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (stats == false) {
                  stats = !stats;
                  print(stats);
                  setState(() {});
                    } else {
                  stats = stats;
                  print(stats);
                    }
                  },
                  child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                    ),
                    color:
          stats ? AppColors.pinkDark : AppColors.kPink2,
                  ),
                  child: CustomText(
                      text: 'Reservations archive'.tr,
                      color: !stats
              ? AppColors.pinkDark
              : Colors.white)),
                ),
              ),
          ],
                      ),
                    ),
                 
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              CustomText(
                text: !stats ? 'Upcoming reservations'.tr : "Reservations archive".tr,
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 2),
                  child: Divider(
                    color: AppColors.kBlack,
                    thickness: 1,
                  ),
                ),
              ),
          ],
                      ),
                    ),
                  stats
                      ? Container()
                      : appGet.myBookings.isEmpty
              ? Center(child: IsLoad())
              : Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: appGet.myBookings['data'].length == 0
                        ? Center(
                            child: Container(
                            height: 100,
                            child: CustomText(
                              text: "No reservations".tr,
                              fontSize: 30,
                            ),
                          ))
                        : RefreshIndicator(
                            onRefresh: () async {
                              return ServerUser.serverUser
                                  .getMyBookings();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    appGet.myBookings['data'].length,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      ServerUser.serverUser
                                          .setBookingDetails(
                                              appGet.myBookings['data']
                                                  [index]['id']);
                                      showMaterialModalBottomSheet(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(20),
                                              topRight:
                                                  Radius.circular(20),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) =>
                                              Container(
                                                height: 280.h,
                                                padding: EdgeInsets
                                                    .symmetric(
                                                        horizontal:
                                                            30.w,
                                                        vertical: 10.h),
                                                decoration:
                                                    BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(
                                                            20),
                                                    topRight:
                                                        Radius.circular(
                                                            20),
                                                  ),
                                                ),
                                                child: Obx(
                                                  () => appGet
                                                          .bookingDetails
                                                          .isEmpty
                                                      ? IsLoad()
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        CustomText(
                                                                      text: 'Booking details'.tr,
                                                                    ),
                                                                  ),
                                                                  CustomRate(
                                                                      rate: appGet.bookingDetails['data']['center']['rate'].toDouble()),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  10.h,
                                                            ),
                                                            CustomText(
                                                                text: 'Timing'.tr+' : ' +
                                                                    '${appGet.bookingDetails['data']['time']}'),
                                                            SizedBox(
                                                              height:
                                                                  10.h,
                                                            ),
                                                            CustomText(
                                                                text: 'the cost'.tr+' : ' +
                                                                    '${appGet.bookingDetails['data']['cost']}' +
                                                                    "Rial".tr),
                                                            SizedBox(
                                                              height:
                                                                  10.h,
                                                            ),
                                                            CustomText(
                                                                text:
                                                                    "services".tr),
                                                            SizedBox(
                                                              height:
                                                                  10.h,
                                                            ),
                                                            appGet.bookingDetails
                                                                    .isEmpty
                                                                ? IsLoad()
                                                                : Expanded(
                                                                    child:
                                                                        ListView.builder(
                                                                      scrollDirection: Axis.horizontal,
                                                                      padding: EdgeInsets.all(0),
                                                                      itemCount: appGet.bookingDetails['data']['services'].length,
                                                                      itemBuilder: (BuildContext context, int index) {
                                                                        return appGet.bookingDetails['data']['services'].length == 0
                                                                            ? Container()
                                                                            : Padding(
                                                                                padding: const EdgeInsets.all(5.0),
                                                                                child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(12),
                                                                                    color: Colors.white,
                                                                                    boxShadow: sShadow2,
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: CustomText(
                                                                                      text: appGet.bookingDetails['data']['services'][index]['name'],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                      },
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),
                                                ),
                                              ));
                                    },
                                    child: UserReservationsItem(
                                      id: appGet.myBookings['data']
                                          [index]['id'],
                                      image: appGet.myBookings['data']
                                          [index]['center']['logo'],
                                      userName:
                                          appGet.myBookings['data']
                                              [index]['center']['name'],
                                      date: appGet.myBookings['data']
                                          [index]['date'],
                                    ),
                                  );
                                }),
                          ),
                  ),
                ),
                  !stats
                      ? Container()
                      : appGet.archiveVisits.isEmpty
              ? Center(child: IsLoad())
              : Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: appGet.archiveVisits['data'].length == 0
                        ? Container(
                            height: 100,
                            child: Center(
                                child: CustomText(
                              text: "No reservations".tr,
                              fontSize: 30,
                            )),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              return ServerUser.serverUser
                                  .getArchiveVisits();
                            },
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    appGet.archiveVisits['data'].length,
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      ServerUser.serverUser
                                          .setBookingDetails(appGet
                                                  .archiveVisits['data']
                                              [index]['id']);
                                      showMaterialModalBottomSheet(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(20),
                                              topRight:
                                                  Radius.circular(20),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) =>
                                              Container(
                                                  height: 280.h,
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                          horizontal:
                                                              30.w,
                                                          vertical:
                                                              10.h),
                                                  decoration:
                                                      BoxDecoration(
                                                          color: Colors
                                                              .white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .only(
                                                            topLeft: Radius
                                                                .circular(
                                                                    20),
                                                            topRight: Radius
                                                                .circular(
                                                                    20),
                                                          ))));
                                    },
                                    child: UserReservationsItem(
                                      id: appGet.archiveVisits['data']
                                          [index]['id'],
                                      image:
                                          appGet.archiveVisits['data']
                                              [index]['center']['logo'],
                                      list: appGet.archiveVisits['data']
                                          [index]['services'],
                                      userName:
                                          appGet.archiveVisits['data']
                                              [index]['center']['name'],
                                      date: appGet.archiveVisits['data']
                                          [index]['date'],
                                    ),
                                  );
                                }),
                          ),
                  ),
                ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
