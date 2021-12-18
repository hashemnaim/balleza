import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Screen_User/more_Screen/widgets/contact_text_form_field.dart';

class EditProductSheet extends StatefulWidget {
  final String title, price, image;
  final int id;

  const EditProductSheet({Key key, this.title, this.price, this.image, this.id})
      : super(key: key);
  @override
  _AddProductSheetState createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<EditProductSheet> {
  final AppGetSalon appGetSalon = Get.find();

  String title;

  String price;

  saveTitle(String value) {
    this.title = value;
    setState(() {});
  }

  savePrice(String value) {
    this.price = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: "Service data".tr),
          SizedBox(
            height: 15.h,
          ),
          CustomTextFormField2(
            minHeight: 43.h,
            hintText: 'Name of the service'.tr,
            onChange: saveTitle,
            initialValue: widget.title,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFormField2(
              initialValue: widget.price,
              minHeight: 43.h,
              hintText: 'Service price'.tr,
              onChange: savePrice),
          SizedBox(
            height: 10.h,
          ),
          // GetBuilder<AppGetSalon>(
          //   init: AppGetSalon(),
          //   builder: (controller) => controller.imageFile == null
          //       ? CustomerImageNetwork(
          //           widget.image,
          //           100,
          //           100,
          //           10,
          //           circle: false,
          //         )
          //       : Container(
          //           height: 150, child: Image.asset(controller.imageFile.path)),
      //    ),
          // Center(
          //   child: GestureDetector(
          //     onTap: () async {
          //       showCupertinoModalPopup(
          //           context: context,
          //           builder: (context) {
          //             return CupertinoActionSheet(
          //               title: CustomText(
          //                 text: "Upload",
          //                 color: Colors.grey,
          //               ),
          //               actions: <Widget>[
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Expanded(
          //                       child: Container(
          //                         child: CupertinoActionSheetAction(
          //                           child: Icon(
          //                             Icons.camera,
          //                             size: 30,
          //                             color: Colors.red,
          //                           ),
          //                           // isDefaultAction: true,
          //                           onPressed: () async {
          //                             appGetSalon.getImage(ImageSource.camera);
          //                             Navigator.pop(context);
          //                           },
          //                         ),
          //                       ),
          //                     ),
          //                     Expanded(
          //                       child: CupertinoActionSheetAction(
          //                         child: Icon(
          //                           Icons.image,
          //                           size: 35,
          //                           color: Colors.red,
          //                         ),

          //                         // isDestructiveAction: true,
          //                         onPressed: () async {
          //                           appGetSalon.getImage(ImageSource.gallery);
          //                           Navigator.pop(context);
          //                           // editImage(
          //                           //     imageFile,
          //                           //     appGet.userInfoModel.value
          //                           //         .data.name);
          //                         },
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //               cancelButton: CupertinoActionSheetAction(
          //                 child: CustomText(text: "cancel"),
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //               ),
          //             );
          //           });
          //     },
          //     child: Container(
          //       height: 72.h,
          //       width: 72.w,
          //       padding: EdgeInsets.all(15),
          //       decoration: BoxDecoration(
          //           color: Color(0xffF5F5F5),
          //           shape: BoxShape.circle,
          //           border: Border.all(
          //             color: Color(0xff171717),
          //           )),
          //       child: SvgPicture.asset(
          //         'assets/svg/addImage.svg',
          //         height: 34.h,
          //         width: 38.w,
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(child: Container()),
          CustomButton(
            onPress: () {
              // print(appGetSalon.imageFile.path ?? "");
              // print(title);
              // print(price);

              // if (appGetSalon.imageFile != null) {
              //   if (title != null && price != null) {
              Navigator.pop(context);

              ServerSalon.serverSalon.setEditService(
                title ?? widget.title,
                price ?? widget.price,
                widget.id,
              );
              //   } else {
              //     setToast(
              //       "يجب اكمال جميع البيانات",
              //     );
              //   }
              // } else {
              //   setToast(
              //     "يجب ارفاق صورة ",
              //   );
              // }
            },
            text: 'Edit'.tr,
          ),
        ],
      ),
    );
  }
}
