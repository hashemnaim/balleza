import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/addProductSheet.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/editProductSheet.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/top_salon_screen.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialog_box.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SalonHomeScreen extends StatefulWidget {
  @override
  _SalonHomeScreenState createState() => _SalonHomeScreenState();
}

class _SalonHomeScreenState extends State<SalonHomeScreen> {
  AppGetSalon appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // resizeToAvoidBottomPadding: false,
      body: Container(
        child: Obx(
          () => Column(
            children: [
              TopSalonScreen(
                title: 'My services'.tr,
                searchWidget: false,
                // height: 90.h,
              ),
              // SizedBox(
              //   height: 10.h,
              // ),
              appGet.services.isEmpty
                  ? Expanded(child: Center(child: IsLoad()))
                  : Expanded(
                                      child: Container(
                        // height: 610,
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.all(0),
                          itemCount: appGet.services['data'].length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                decoration: customDecoration2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomerImageNetwork(
                                        appGet.services['data'][index]['photo'],
                                        100,
                                        100,
                                        40,
                                        circle: false,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: appGet.services['data'][index]
                                                ['title'],
                                            color: AppColors.kBlack,
                                          ),
                                          CustomText(
                                            text: "السعر : " +
                                                appGet.services['data'][index]
                                                    ['price'],
                                            color: AppColors.kBlack,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: setW(40, context),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                showMaterialModalBottomSheet(
                                                    elevation: 2,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    context: context,
                                                    builder:
                                                        (context) =>
                                                            EditProductSheet(
                                                              title: appGet.services[
                                                                          'data']
                                                                      [index]
                                                                  ['title'],
                                                              price: appGet.services[
                                                                          'data']
                                                                      [index]
                                                                  ['price'],
                                                              image: appGet.services[
                                                                          'data']
                                                                      [index]
                                                                  ['photo'],
                                                              id: appGet.services[
                                                                      'data']
                                                                  [index]['id'],
                                                            )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  CustomDialogBox(
                                                "Do you want to delete the service?".tr,
                                                onPress: () => ServerSalon
                                                    .serverSalon
                                                    .setDeleteService(
                                                        appGet.services['data']
                                                            [index]['id']),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                        ),
                      ),
                  ),
              //     Expanded(
              // child: SalonList(),
              //     ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                child: CustomButton(
                  onPress: () {
                    showMaterialModalBottomSheet(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (context) => AddProductSheet());
                  },
                  text: 'Add a new service'.tr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
