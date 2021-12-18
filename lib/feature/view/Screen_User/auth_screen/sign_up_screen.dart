import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/connectvity_service.dart';
import 'package:belleza/feature/server/server_auth.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/widgets/mobile_number_with_country.dart';
import 'package:belleza/feature/view/widgets/custom_dropDown.dart';
import 'package:belleza/feature/view/widgets/custom_text_field.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegestrationScreen extends StatefulWidget {
  @override
  _RegestrationScreenState createState() => _RegestrationScreenState();
}

class _RegestrationScreenState extends State<RegestrationScreen> {
  GlobalKey<FormState> regestrationFormKey = GlobalKey();
  final focus = FocusNode();
  String name;
  String address;
  int indexCity;
  int indexCatg;
  String email;
  String phoneNumber;
  String password;
  AppGetUser appGet = Get.find();
  saveFirstName(String value) {
    this.name = value;
    print(value);
  }

  saveAddreas(String value) {
    this.address = value;
    print(value);
  }

  saveEmail(String value) {
    this.email = value;
    print(value);
  }

  savePhaoneNumber(String countryCode, String mobileNumber) {
    this.phoneNumber = mobileNumber;
  }

  savePassword(String value) {
    this.password = value;
  }

  setNameValidator(String value) {
    if (value == null || value.isEmpty) {
      return "noName".tr;
    }
  }

  setaddressValidator(String value) {
    if (value == null || value.isEmpty) {
      return "noAddress".tr;
    }
  }

  validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return "wrongPassword".tr;
    } else if (value.length < 8) {
      return "wrongPassword".tr;
    }
  }

  setMobileValidator(String value) {
    if (value == null || value.isEmpty) {
      return "noMobile".tr;
    }
  }

  setEmailValidator(String value) {
    if (value == null || value.isEmpty) {
      return "noEmail".tr;
    }
  }

  saveForm() async {
    if (regestrationFormKey.currentState.validate()) {
      if (appGet.acceptTerms.value == false) {
        CustomDialougs.utils.showDialoug(
            titleKey: 'alert'.tr,
            messageKey: 'You must agree to the usage policy'.tr);

        return;
      }

      regestrationFormKey.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
        String fcmToken = await _firebaseMessaging.getToken();
        ServerAuth.serverAuth.registerUser(
            name, phoneNumber, password, fcmToken, address, indexCity,email);
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error'.tr, titleKey: 'alert'.tr);
      }
    }
  }

  AppGetUser appGetuser = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.only(top: 20.h),
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                        height: 10.h,
                      ),
                      /////////////////////////////////////////////////////////////////////////////////////////
                      Form(
                        key: regestrationFormKey,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              CustomTextFormField(
                                hintText: 'name'.tr,
                                icon: Icons.account_circle,
                                validator: setNameValidator,
                                onSaved: saveFirstName,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomTextFormField(
                                hintText: 'email'.tr,
                                icon: Icons.alternate_email,
                                validator: setEmailValidator,
                                onSaved: saveEmail,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomTextFormField(
                                hintText: 'address'.tr,
                                icon: Icons.location_on,
                                validator: setaddressValidator,
                                onSaved: saveAddreas,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CategoriesDropDown(
                                list: appGetuser.cities['data'],
                                name: "name",
                                hint: "Choose a city".tr,
                                index: indexCity,
                                icon: Icons.location_city,
                                dropDownBtnFunction: (value) {
                                  indexCity = value - 1;
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              MobileNumberTextField(
                                fun: savePhaoneNumber,
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomTextFormField(
                                hintText: 'password'.tr,
                                icon: Icons.lock,
                                validator: validatePassword,
                                onSaved: savePassword,
                                password: true,
                              ),
                              Obx(() {
                                return CheckboxListTile(
                                  checkColor: Colors.white,
                                  title: Row(
                                    children: [
                                      CustomText(
                                        text:
                                            'You must agree to the usage policy'
                                                .tr,
                                      ),
                                    ],
                                  ),
                                  value: appGet.acceptTerms.value,
                                  onChanged: (value) {
                                    appGet.changeAcceptTerms(value);
                                  },
                                );
                              }),
                              SizedBox(
                                height: 12.h,
                              ),
                              CustomButton(
                                onPress: saveForm,
                                text: 'signUp2'.tr,
                              )
                            ],
                          ),
                        ),
                      ),
                      ////////////////////////////////////////////////////////////////////////////////////////////
                    ],
                  ),
                ))));
  }
}
