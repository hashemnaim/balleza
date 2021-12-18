import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/server_user.dart';

import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:belleza/feature/view/widgets/custom_dialog_box.dart';
import 'package:get/get.dart';

class UserReservationsItem extends StatelessWidget {
  final String userName, date, image;
  final List list;
  final int id;
  final bool cancel;
  final bool save;
  final AppGetSalon getSalon = Get.find();
  UserReservationsItem({
    this.userName,
    this.image,
    this.date,
    this.list,
    this.cancel = true,
    this.save = true,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: CustomerImageNetwork(
                  image,
                  80,
                  80,
                  25,
                  circle: false,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: userName,
                    ),
                    CustomText(
                      text: '$date',
                    ),
                  ],
                ),
              ),
              !cancel
                  ? Container()
                  : Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => CustomDialogBox(
                                  "Do you want to cancel the reservation?".tr,
                                  onPress: () => ServerUser.serverUser
                                      .setBookingcCancel(id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                  height: 29.h,
                                  width: 29.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Divider(
            color: Color(0xffB8B6B6),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
