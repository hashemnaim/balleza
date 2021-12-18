import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/top_user_screen.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/style.dart';
import 'package:get/get.dart';

import 'widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  final AppGetUser appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopUserScreen(
            title: '',
            searchWidget: false,
            back: true,
                                            height: 110.h,

          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications'.tr,
                  style: kSalonTextStyle,
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
          Obx(
            () => appGet.notifiaction.isEmpty
                ? Expanded(child: Center(child: IsLoad()))
                : Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Container(
                          child: appGet.notifiaction['data'].length == 0
                              ? Center(child: CustomText(text: 'There are no notifications'))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: appGet.notifiaction['data'].length,
                                  scrollDirection: Axis.vertical,
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: NotificationItem(
                                        image: appGet.notifiaction['data']
                                            [index]['image'],
                                        userName: appGet.notifiaction['data']
                                            [index]['name'],
                                        title: '',
                                      ),
                                    );
                                  })),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
