import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/salon_reservation_item.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/top_salon_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/top_user_screen.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:get/get.dart';

class SalonReservationsScreen extends StatefulWidget {
  @override
  _SalonReservationsScreenState createState() =>
      _SalonReservationsScreenState();
}

class _SalonReservationsScreenState extends State<SalonReservationsScreen> {
  AppGetSalon appGet = Get.find();
  bool stats = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Obx(
          () => Column(
            children: [
              TopSalonScreen(
                title: 'Reservations'.tr,
                searchWidget: false,
                // height: 90.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                // height: 35.h,
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
                      ? Expanded(child: Center(child: IsLoad()))
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                                  onRefresh: (){
                                 return  ServerSalon.serverSalon. getMyBookingsSalon();
                                  },
                                                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: appGet.myBookings['data'].length,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (context, index) {
                                        return SalonReservationsItem(
                                          id: appGet.myBookings['data'][index]
                                              ['id'],
                                          image: appGet.myBookings['data'][index]
                                              ['user']['image'],
                                          userName: appGet.myBookings['data']
                                              [index]['user']['name'],
                                          date: appGet.myBookings['data'][index]
                                              ['date'],
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
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                                  onRefresh: (){
                                 return  ServerSalon.serverSalon. getArchiveVisitsSalon();
                                  },
                                                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount:
                                          appGet.archiveVisits['data'].length,
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.all(0),
                                      itemBuilder: (context, index) {
                                        return SalonReservationsItem(
                                          cancel: false,
                                          save: false,
                                          id: appGet.archiveVisits['data'][index]['id'],
                                          image: appGet.archiveVisits['data']
                                              [index]['user']['image'],
                                          list: appGet.archiveVisits['data']
                                              [index]['services'],
                                          userName: appGet.archiveVisits['data']
                                              [index]['user']['name'],
                                          date: appGet.archiveVisits['data']
                                              [index]['date'],
                                        );
                                      }),
                                ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
