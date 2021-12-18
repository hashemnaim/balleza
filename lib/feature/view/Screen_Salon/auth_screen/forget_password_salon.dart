import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/connectvity_service.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/widgets/mobile_number_with_country.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordSalon extends StatefulWidget {
  @override
  _EnterMobileNumberState createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<ForgetPasswordSalon> {
  GlobalKey<FormState> phoneForm = GlobalKey();

  String mobileNumber;
  AppGetSalon appGet = Get.find();
  Function saveMobileNumber(String mobileNumber) {
    this.mobileNumber = mobileNumber;
    return null;
  }

  Function nextButtonFunction() {
    if (phoneForm.currentState.validate()) {
      phoneForm.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
        appGet.mobileNumber = mobileNumber;
        appGet.pr.show();
        // forgetPassword(mobileNumber: mobileNumber);
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error'.tr, titleKey: 'alert'.tr);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'forgetBar'.tr,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 100.h,
            ),
            Form(
              key: phoneForm,
              child: MobileNumberTextField(
                fun: saveMobileNumber,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            CustomButton(
              text: 'next'.tr,
              onPress: nextButtonFunction,
            )
          ],
        ),
      ),
    );
  }
}
