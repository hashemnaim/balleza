import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/connectvity_service.dart';
import 'package:belleza/feature/server/helper/s_helpar.dart';
import 'package:belleza/feature/server/server_auth.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_Salon/auth_screen/forget_password_salon.dart';
import 'package:belleza/feature/view/widgets/custom_text_field.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sign_up_screen.dart';

class SignInScreenUser extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInScreenUser> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String mobileNumber;
  String password;
  AppGetUser appGet = Get.find();

  saveMobikeNumber(String value) {
    this.mobileNumber = value;
  }

  savePassword(String password) {
    this.password = password;
  }

  setMobileValidator(String value) {
    if (value == null || value.isEmpty) {
      return "noMobile".tr;
    } else if (value.length < 8) {
      return "noMobile".tr;
    }
  }

  setNameValidator(String value) {
    if (value == null || value.isEmpty) {
      return "noName".tr;
    }
  }

  setPasswordValidator(String value) {
    if (value == null || value.isEmpty) {
      return "wrongPassword".tr;
    } else if (value.length < 6) {
      return "wrongPassword".tr;
    }
  }

  saveForm() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
        String fcmToken = await SHelper.sHelper.getValue(
          "fcmToken",
        );

        ServerAuth.serverAuth.loginUser(mobileNumber, password, fcmToken);
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error'.tr, titleKey: 'alert'.tr);
      }
    }
  }

  forgetPassword() {
    Get.to(() => ForgetPasswordSalon());
  }

  createNewAccount() {
    Get.to(() => RegestrationScreen());
  }

  gesetAccount() async {
    String fcmToken = await SHelper.sHelper.getValue("fcmToken");
    ServerAuth.serverAuth.loginUser("0098765425", "12345678", fcmToken);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          //  margin: EdgeInsets.only(top: 20.h),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.language),
                            CustomText(
                              text: "language".tr,
                              fontSize: 14,
                            ),
                            SizedBox(width: setW(20, context)),
                            DropdownButton(
                                items: [
                                  DropdownMenuItem(
                                    child: Text("ع"),
                                    value: 'ar',
                                  ),
                                  DropdownMenuItem(
                                    child: Text("en"),
                                    value: 'en',
                                  ),
                                ],
                                value: appGet.language.value,
                                onChanged: (value) async {
                                  appGet.language.value = value;
                                  await SHelper.sHelper
                                      .addNew("Lang", appGet.language.value);
                                  Get.updateLocale(
                                      Locale(appGet.language.value));
                                }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: setH(20, context),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/logo.png'),
                          CustomText(
                              text: 'please Login your account'.tr,
                              fontSize: 24.sp,
                              color: AppColors.pinkDark),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        child: Column(
                          children: <Widget>[
                            CustomTextFormField(
                              icon: Icons.phone,
                              hintText: 'mobile'.tr,
                              onSaved: saveMobikeNumber,
                              validator: setMobileValidator,
                              textInputType: TextInputType.number,
                            ),

                            SizedBox(
                              height: 15.h,
                            ),
                            CustomTextFormField(
                              icon: Icons.lock,
                              hintText: 'password'.tr,
                              onSaved: savePassword,
                              validator: setPasswordValidator,
                              password: true,
                            ),
                            // MyTextField(
                            //   hintTextKey: 'كلمة المرور',
                            //   iconData: Icons.lock,
                            //   validateFunction: validatepasswordFunction,
                            //   saveFunction: savePassword,
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        forgetPassword();
                      },
                      child: CustomText(
                        text: 'forget'.tr,
                        alignment: Alignment.centerRight,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Container(
                      width: setW(350, context),
                      child: CustomButton(
                        onPress: saveForm,
                        text: 'login'.tr,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: 'dont have an account?'.tr,
                          fontSize: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            createNewAccount();
                          },
                          child: CustomText(
                              text: 'signUp'.tr, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Divider(),
                        )),
                        CustomText(text: "or".tr),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Divider(),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          // await Location.location.getCurrentLocation();

                          gesetAccount();
                        },
                        child: CustomText(
                            text: ('Log in as a visitor'.tr),
                            fontSize: 20,
                            color: AppColors.primaryColor),
                      ),
                    ),

                    SizedBox(
                      height: 15.h,
                    ),
                    // SocialMediaLogin(
                    //   facebookLoginFun: this.facebookLogin,
                    //   gmailLoginFun: this.gmailLogin,
                    //   twitterLoginFun: this.twiterLogin,
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
