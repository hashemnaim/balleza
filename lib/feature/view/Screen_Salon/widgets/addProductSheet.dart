import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Screen_User/more_Screen/widgets/contact_text_form_field.dart';

class AddProductSheet extends StatefulWidget {
  @override
  _AddProductSheetState createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<AddProductSheet> {
  final AppGetSalon appGetSalon = Get.find();
  GlobalKey<FormState> regestrationFormKey = GlobalKey();

  String title;

  String price;

  // saveTitle(String value) {
  //   this.title = value;
  //   setState(() {});
  // }

  // savePrice(double value) {
  //   this.price = value;
  //   print(value);
  //   setState(() {});
  // }

  validateNull(String value) {
    if (value == '') {
      return 'There are no data'.tr;
    }
  }

  saveForm() async {
    if (regestrationFormKey.currentState.validate()) {
      // regestrationFormKey.currentState.save();

      
                    Navigator.pop(context);

      ServerSalon.serverSalon.setAddService(
        title,
        price,
      );
    }
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
      child: Container(
        // height: 300.h,

        child: Form(
          key: regestrationFormKey,
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
                onChange: (value) {
                  this.title = value;
                  setState(() {});
                },
                validator: validateNull,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextFormField2(
                  minHeight: 43.h,
                  hintText: 'Service price'.tr,
                  onChange: (value) {
                    this.price = value;
                    setState(() {});
                  },
                  validator: validateNull,
                  textInputType: TextInputType.number),
              SizedBox(
                height: 10.h,
              ),
              // GetBuilder<AppGetSalon>(
              //   init: AppGetSalon(),
              //   builder: (controller) => controller.imageFile == null
              //       ? Container()
              //       : Container(
              //           height: 150,
              //           child: Image.asset(controller.imageFile.path)),
              // ),
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
                onPress: saveForm,
                text: 'send'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
