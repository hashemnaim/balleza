import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/top_salon_screen.dart';
import 'package:belleza/feature/view/Screen_User/more_Screen/widgets/notification_item.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:get/get.dart';

class NotificationSalonScreen extends StatelessWidget {
  final AppGetSalon appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopSalonScreen(
            title: '',
            searchWidget: false,
            back: true,
            nofiction: false,
          ),
          SizedBox(
            height: 35.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text:
                  'Notifications'.tr,
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
                        child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: appGet.notifiaction['data'].length,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) {
                              print(appGet.notifiaction['data'].length);
                              return appGet.notifiaction['data'].length == 0 ?
                               Expanded(child: Center(child: CustomText(text: 'There are no notifications'.tr))) :
                                   GestureDetector(
                                      onTap: () {},
                                      child: NotificationItem(
                                        image: appGet.notifiaction['data']
                                            [index]['image'],
                                        userName: appGet.notifiaction['data']
                                            [index]['name'],
                                        title: '',
                                      ),
                                    );
                                  
                            }),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
