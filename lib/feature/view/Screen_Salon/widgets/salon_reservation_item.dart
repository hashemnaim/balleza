import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/widgets/custom_dialog_box.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SalonReservationsItem extends StatelessWidget {
  final String userName, date, image;
  final List list;
  final int id;
  final bool cancel;
  final bool save;
  final AppGetSalon getSalon = Get.find();
  SalonReservationsItem({
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
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomerImageNetwork(
                    image,
                    20,
                    20,
                    25,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
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
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ServerSalon.serverSalon.setBookingDetailsSalon(id);
                      showMaterialModalBottomSheet(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) => Container(
                          height: 280.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Obx(
                            () => Column(
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Reservation data'.tr,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomText(text: "services".tr)),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                getSalon.bookingDetails.isEmpty
                                    ? IsLoad()
                                    : Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: getSalon
                                              .bookingDetails['data']
                                                  ['services']
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white,
                                                  boxShadow: sShadow2,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: CustomText(
                                                    text: getSalon
                                                                .bookingDetails[
                                                            'data']['services']
                                                        [index]['name'],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                Expanded(child: Container()),
                                !save
                                    ? Container()
                                    : CustomButton(
                                        onPress: () {
                                          Navigator.pop(context);

                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CustomDialogBox(
                                              'Do you want to confirm your reservation?'.tr,
                                              onPress: () => ServerSalon
                                                  .serverSalon
                                                  .setBookingAccept(id),
                                            ),
                                          );
                                        },
                                        text: 'save'.tr,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kGreen,
                          border:
                              Border.all(color: Color(0xffFED5E1), width: 5)),
                      child: Container(
                          height: 28.h,
                          width: 28.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: !save ? Colors.grey : AppColors.kGreen,
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: Colors.white,
                            size: 12,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  !cancel
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CustomDialogBox(
                                "Do you want to cancel the reservation?".tr,
                                onPress: () => ServerSalon.serverSalon
                                    .setBookingcCancelSalon(id),
                              ),
                            );
                          },
                          child: Container(
                              height: 39.h,
                              width: 39.h,
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
                ],
              ),
         
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 65.w),
          child: Divider(
            color: Color(0xffB8B6B6),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
