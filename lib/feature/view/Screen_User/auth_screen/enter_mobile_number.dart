import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/connectvity_service.dart';
import 'package:belleza/feature/view/widgets/mobile_number_with_country.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnterMobileNumber extends StatefulWidget {
  @override
  _EnterMobileNumberState createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {
  GlobalKey<FormState> phoneForm = GlobalKey();

  String mobileNumber;
  final AppGetUser appGet = Get.find();
  Function saveMobileNumber(String mobileNumber) {
    this.mobileNumber = mobileNumber;
    return () {};
  }

  Function nextButtonFunction() {
    if (phoneForm.currentState.validate()) {
      phoneForm.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
        appGet.mobileNumber = mobileNumber;
        appGet.pr.show();
        return () {};
        // forgetPassword(mobileNumber: mobileNumber);
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error'.tr, titleKey: 'alert'.tr);
        return () {};
      }
    }
    return () {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: BaseAppbar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 50.h,
            ),
            CustomText(
              text: 'forget'.tr,
              // style: Styles.titleTextStyle,
            ),
            Text('write_mobile_number'.tr),
            SizedBox(
              height: 35.h,
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
              text: 'next',
              onPress: nextButtonFunction,
            )
          ],
        ),
      ),
    );
  }
}
