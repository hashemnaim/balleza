import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/helper/s_helpar.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feature/values/colors.dart';
import 'feature/view/Screen_Salon/auth_screen/sign_in_screen.dart';
import 'feature/view/Screen_User/auth_screen/sign_in_screen.dart';
import 'feature/view/widgets/custom_text.dart';

class CompleteSignUp1 extends StatelessWidget {
  final AppGetUser appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200.h,
            ),
               Center(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          CustomText(
              text: 'welcome'.tr, fontSize: 24.sp, color: AppColors.pinkDark),
        ],
      ),),
            SizedBox(
              height: 90.h,
            ),
            CustomButton(
              text: 'Register as a beauty salon'.tr,
              onPress: () async {
                kNavigatorPush(context, SignInScreenSalon());
                appGet.type = 1;
                await SHelper.sHelper.addNew("type", "s");
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              text: 'Register as a customer'.tr,
              onPress: () async {
                                                        // await  Location.location.getCurrentLocation2();

                kNavigatorPush(context, SignInScreenUser());
                appGet.type = 2;
                await SHelper.sHelper.addNew("type", "u");
              },
            ),
          ],
        ),
      ),
    );
  }
}
