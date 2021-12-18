import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/animate_do.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_User/auth_screen/sign_in_screen.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialog_box.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:belleza/feature/values/style.dart';
import 'package:get/get.dart';
import '../../widgets/animationCart.dart';
import '../../widgets/custom_calendar.dart';
import '../main_user_screen.dart';

class ReservationsNew extends StatefulWidget {
  final int id;

  const ReservationsNew({Key key, this.id}) : super(key: key);
  @override
  _ReservationsNewState createState() => _ReservationsNewState();
}

class _ReservationsNewState extends State<ReservationsNew> {
  int _current = -1;
  AppGetUser appGet = Get.find();

  String paymentdGroup;
  int idPaymentdGroup = 3;
  String servicesGroup;
  int idServicesGroup = 3;
  setServicesGroup(String value) {
    this.servicesGroup = value;
    setState(() {});
  }

  setPaymentdGroup(String value) {
    this.paymentdGroup = value;
    setState(() {});
  }

  List<String> typeServices = ['The salon'.tr, 'Household'.tr];
  List<String> paymentMethod = [
    'Online payment'.tr,
    'Paiement when recieving'.tr
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 680.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Add a new reservation'.tr,
                      style: kBtnTextStyle2.copyWith(fontSize: 18.sp),
                    ),
                  ],
                ),
                Calendar(id: widget.id),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appGet.hoursAvailableInDate.isEmpty
                          ? SpinKitChasingDots(
                              color: AppColors.primaryColor,
                              size: 50.0,
                            )
                          : appGet.hoursAvailableInDate['data'].length == 0
                              ? Center(
                                  child: CustomText(
                                      text: "There are no times available".tr))
                              : GridView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: appGet
                                      .hoursAvailableInDate['data'].length,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 2,
                                    mainAxisSpacing: 1,
                                    crossAxisSpacing: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    bool selected = _current == index;
                                    return GestureDetector(
                                      onTap: () {
                                        if (appGet.hoursAvailableInDate['data']
                                            [index]["available"] = true) {
                                          _current = index;
                                          setState(() {});
                                        }
                                      },
                                      child: Obx(
                                        () => Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: selected
                                                    ? AppColors.primaryColor
                                                    : appGet.hoursAvailableInDate[
                                                                        'data']
                                                                    [index]
                                                                ['available'] ==
                                                            true
                                                        ? Colors.white
                                                        : Colors.grey,
                                                boxShadow: sShadow2,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              width: 100.w,
                                              height: 43.h,
                                              child: Center(
                                                child: Text(
                                                  appGet.hoursAvailableInDate[
                                                      'data'][index]["time"],
                                                  style:
                                                      kBtnTextStyle2.copyWith(
                                                          fontSize: 16.sp,
                                                          color: selected
                                                              ? Colors.white
                                                              : appGet.hoursAvailableInDate['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          "available"] ==
                                                                      true
                                                                  ? AppColors
                                                                      .primaryColor
                                                                  : Colors
                                                                      .white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                      SizedBox(
                        height: 10.h,
                      ),
                      // SizedBox(
                      //   height: 8.h,
                      // ),
                      appGet.allIdCategories.length < 1
                          ? Container()
                          : CustomText(
                              text: 'Available services'.tr,
                            ),
                      SizedBox(
                        height: 8.h,
                      ),
                      GetBuilder<AppGetUser>(
                        init: AppGetUser(),
                        builder: (controller) {
                          return controller.allIdCategories.length < 1
                              ? Container()
                              : GridView.builder(
                                  padding: EdgeInsets.all(0),
                                  itemBuilder: (context, index) {
                                    // index =appGet.allCategories
                                    return GestureDetector(
                                      onTap: () async {
                                        if (controller.allIdCategories.contains(
                                            controller
                                                .allIdCategories[index])) {
                                          controller.removeAllCategories(
                                              index,
                                              controller
                                                  .allIdCategories[index]);
                                        }
                                      },
                                      child: AnimationCart(
                                        grid: true,
                                        index: index,
                                        count:
                                            controller.allIdCategories.length,
                                        duration: 1500,
                                        child: Stack(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                                boxShadow: sShadow2,
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Expanded(
                                                    child: CustomText(
                                                        text: controller
                                                                    .centerById[
                                                                'data']['services']
                                                            [index]['title']),
                                                  ),
                                                  Expanded(
                                                    child: CustomText(
                                                      text: "price".tr +
                                                          ":" +
                                                          controller.centerById[
                                                                      'data']
                                                                  ['services']
                                                              [index]['price'],
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            appGet.allIdCategories.contains(
                                                    controller
                                                        .allIdCategories[index])
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                          )),
                                                      child: Icon(
                                                        Icons.done,
                                                        color: Colors.green,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  physics: const BouncingScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: controller.allIdCategories.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1.4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 0.6),
                                );
                        },
                      ),
                      CustomText(
                        text: 'service type'.tr,
                      ),
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                activeColor: AppColors.primaryColor,
                                value: typeServices[0],
                                groupValue: servicesGroup,
                                onChanged: (value) {
                                  idServicesGroup = 0;
                                  setServicesGroup(value);
                                },
                                title: CustomText(
                                  text: typeServices[0],
                                ),
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                activeColor: AppColors.primaryColor,
                                value: typeServices[1],
                                groupValue: servicesGroup,
                                onChanged: (value) {
                                  idServicesGroup = 1;

                                  setServicesGroup(value);
                                },
                                title: CustomText(
                                  text: typeServices[1],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomText(
                        text: 'Payment method'.tr,
                      ),
                      Column(
                        children: [
                          // RadioListTile(
                          //   activeColor: AppColors.primaryColor,
                          //   value: paymentMethod[0],
                          //   groupValue: paymentdGroup,
                          //   onChanged: (value) {
                          //     idPaymentdGroup = 0;
                          //     setPaymentdGroup(value);
                          //   },
                          //   title: CustomText(text:
                          //     paymentMethod[0],

                          //   ),
                          // ),
                          RadioListTile(
                            activeColor: AppColors.primaryColor,
                            value: paymentMethod[1],
                            groupValue: paymentdGroup,
                            onChanged: (value) {
                              idPaymentdGroup = 1;

                              setPaymentdGroup(value);
                            },
                            title: CustomText(
                              text: paymentMethod[1],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          // height: 45.h,
                          width: double.infinity,
                          child: CustomButton(
                              onPress: () {
                                if (appGet.userProfil["data"]['mobile'] ==
                                    "0098765425") {
                                  showDialog(
                                      context: context,
                                      builder: (context) => CustomDialogBox(
                                            "You must be logged in".tr,
                                            onPress: () {
                                              Get.to(SignInScreenUser());
                                            },
                                          ));
                                } else {
                                  if (_current == -1) {
                                    setToast(
                                        "The date of the visit must be fixed"
                                            .tr);
                                  } else {
                                    showDialog(
                                        useSafeArea: true,
                                        barrierDismissible: false,
                                        context: context,
                                        builder:(context) =>  Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Dialog(
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                child: BounceInDown(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: SizedBox(
                                                    height: 400.h,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Center(
                                                          child: CustomText(
                                                            text:
                                                                'Booking details'
                                                                    .tr,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                                text: 'Date'
                                                                        .tr +
                                                                    ':' +
                                                                    '${appGet.data.value == "0" ? DateTime.now().toIso8601String().substring(0, 10) : appGet.data.value}'),
                                                            CustomText(
                                                                text: 'Timing : ' +
                                                                    '${appGet.hoursAvailableInDate['data'][_current]["time"]}'),
                                                            CustomText(
                                                                text: 'service type'
                                                                        .tr +
                                                                    ': ' +
                                                                    '$servicesGroup'),
                                                          ],
                                                        ),
                                                        Divider(),
                                                        CustomText(
                                                            text:
                                                                "services".tr),
                                                        Divider(),
                                                        Expanded(
                                                          child: Container(
                                                            color: Colors.grey,
                                                            child: ListView
                                                                .builder(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              itemCount: appGet
                                                                  .allIdCategories
                                                                  .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return appGet
                                                                            .centerById['data']['services']
                                                                            .length ==
                                                                        0
                                                                    ? Container()
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(5.0),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            CustomText(
                                                                                text: "service".tr + " : " + appGet.centerById['data']['services'][index]['title'],
                                                                                color: Colors.white),
                                                                            CustomText(
                                                                                text: "price".tr + " : " + appGet.centerById['data']['services'][index]['price'] + "Rial".tr,
                                                                                color: Colors.white),
                                                                          ],
                                                                        ),
                                                                      );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              CustomText(
                                                                text:
                                                                    "total amount"
                                                                        .tr,
                                                              ),
                                                              CustomText(
                                                                text: appGet
                                                                        .totalPrice
                                                                        .toString() +
                                                                    "Rial".tr,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                            height: 45.h,
                                                            width:
                                                                double.infinity,
                                                            child: CustomButton(
                                                                onPress: () {
                                                                  if (_current !=
                                                                          -1 &&
                                                                      idPaymentdGroup !=
                                                                          3 &&
                                                                      idServicesGroup !=
                                                                          3) {
                                                                    ServerUser
                                                                        .serverUser
                                                                        .getAddAppointment(
                                                                      widget.id,
                                                                      appGet.data.value ==
                                                                              "0"
                                                                          ? DateTime.now().toIso8601String().substring(
                                                                              0,
                                                                              10)
                                                                          : appGet
                                                                              .data
                                                                              .value,
                                                                      appGet.hoursAvailableInDate['data']
                                                                              [
                                                                              _current]
                                                                          [
                                                                          "time"],
                                                                      idPaymentdGroup +
                                                                          1,
                                                                      idServicesGroup +
                                                                          1,
                                                                      appGet
                                                                          .allIdCategories,
                                                                    );

                                                                    Get.snackbar(
                                                                        "The appointment was successfully booked"
                                                                            .tr,
                                                                        "",
                                                                        colorText:
                                                                            Colors.white);
                                                                    Navigator.pop(
                                                                        context);

                                                                    var delay =
                                                                        Duration(
                                                                            seconds:
                                                                                1);
                                                                    Future.delayed(
                                                                        delay,
                                                                        () {
                                                                      appGet
                                                                          .setindexNav(
                                                                              1);
                                                                      Get.offAll(
                                                                          MainUserScreen());
                                                                    });
                                                                  } else {
                                                                    setToast(
                                                                        "Please complete the rest of the information"
                                                                            .tr);
                                                                  }
                                                                },
                                                                text:
                                                                    "Confirm payment"
                                                                        .tr)),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ))),
                                          ),
                                        ));

                                    // Get.snackbar("تم حجز الموعد بنحاح", "",
                                    //     colorText: Colors.white);
                                    // var delay = Duration(seconds: 1);
                                    // Future.delayed(delay, () {
                                    //   appGet.setindexNav(1);
                                    //   Get.offAll(MainUserScreen());
                                    // });
                                  }
                                }
                              },
                              text: "Book now".tr)),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
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
