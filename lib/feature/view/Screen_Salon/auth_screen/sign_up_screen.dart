import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/connectvity_service.dart';
import 'package:belleza/feature/server/server_auth.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/widgets/custom_dropDown.dart';
import 'package:belleza/feature/view/widgets/custom_text_field.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:string_validator/string_validator.dart';
import '../../widgets/mobile_number_with_country.dart';

class RegestrationScreenSalon extends StatefulWidget {
  @override
  _RegestrationScreenState createState() => _RegestrationScreenState();
}

class _RegestrationScreenState extends State<RegestrationScreenSalon> {
  GlobalKey<FormState> regestrationFormKey = GlobalKey();
  final focus = FocusNode();
  String name;
  String address;
  String startTime = "09:00";
  String endTime = "04:00";
  int indexCity;
  int indexCatg;
  String email;
  String phoneNumber;
  String password;
  AppGetSalon appGet = Get.find();
  AppGetUser appGetuser = Get.find();
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
    print(value);
  }

  validateNull(String value) {
    if (value == '') {
      return translator.translate('لا يوجد بيانات');
    }
  }

  validateEmail(String value) {
    if (value == '') {
      return translator.translate('لا يوجد بيانات');
    } else if (!isEmail(value)) {
      return translator.translate('ايميل خاطئ');
    }
  }

  validatePassword(String value) {
    if (value == '') {
      return translator.translate('لا يوجد بيانات');
    }
    // } else if (value.length < 8) {
    //   return translator.translate('يجب ان تتكون من ٨ ارقام');
    // }
  }

  saveForm() async {
    if (regestrationFormKey.currentState.validate()) {
      if (appGet.acceptTerms.value == false) {
        CustomDialougs.utils.showDialoug(
            titleKey: 'تنبيه', messageKey: 'يجب الموافقة على سياسة الاستخدام');

        return;
      }
      regestrationFormKey.currentState.save();
      if (ConnectivityService.connectivityStatus !=
          ConnectivityStatus.Offline) {
        // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
        // String fcmToken = await _firebaseMessaging.getToken();
        // print(fcmToken);
        // getAllVaraibles();
        ServerAuth.serverAuth.registerSalon(name, phoneNumber, password,
            "fcmToken", address, indexCity, email, startTime, endTime);
      } else {
        CustomDialougs.utils
            .showDialoug(messageKey: 'network_error', titleKey: 'alert');
      }
    }
  }

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
                                text: 'اهلا و سهلاً',
                                fontSize: 24.sp,
                                color: AppColors.pinkDark),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Form(
                        key: regestrationFormKey,
                        child: Container(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              CustomTextFormField(
                                hintText: 'name'.tr,
                                icon: Icons.account_circle,
                                validator: validateNull,
                                onSaved: saveFirstName,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                hintText: 'email'.tr,
                                icon: Icons.alternate_email,
                                validator: validateEmail,
                                onSaved: saveEmail,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              MobileNumberTextField(
                                fun: savePhaoneNumber,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                hintText: 'password'.tr,
                                icon: Icons.lock,
                                validator: validatePassword,
                                onSaved: savePassword,
                                password: true,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              // CategoriesDropDown(
                              //   list: appGetuser.cities['data'],
                              //   name: "name",
                              //   hint: "Choose a city".tr,
                              //   index: indexCity,
                              //   icon: Icons.location_city,
                              //   dropDownBtnFunction: (value) {
                              //     indexCity = value - 1;
                              //     setState(() {});
                              //   },
                              // ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomTextFormField(
                                hintText: 'address'.tr,
                                icon: Icons.location_on,
                                validator: validateNull,
                                onSaved: saveAddreas,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CategoriesDropDown(
                                list: appGetuser.categories['data'],
                                name: "title",
                                hint: "Choose a rating".tr,
                                index: indexCatg,
                                icon: Icons.category,
                                dropDownBtnFunction: (value) {
                                  indexCatg = value - 1;
                                  setState(() {});
                                },
                              ),

                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText(text: "Working hours".tr),
                              Row(
                                children: [
                                  Expanded(
                                    child: DateTimePicker(
                                      type: DateTimePickerType.time,
                                      // dateMask: 'd MMM, yyyy',
                                      initialValue: startTime,
                                      // firstDate: DateTime(2000),
                                      // lastDate: DateTime(2100),
                                      icon: Icon(Icons.event),
                                      // dateLabelText: 'Date',
                                      timeLabelText: "from".tr + " :",
                                      style: GoogleFonts.cairo(fontSize: 18),

                                      onChanged: (val) {
                                        print(val);
                                        startTime = val;
                                        print(startTime);
                                      },
                                      validator: (val) {
                                        print(val);
                                        return null;
                                      },
                                      onSaved: (val) => print(val),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DateTimePicker(
                                      type: DateTimePickerType.time,
                                      // dateMask: 'd MMM, yyyy',
                                      initialValue: endTime,
                                      // firstDate: DateTime(2000),
                                      // lastDate: DateTime(2100),
                                      icon: Icon(Icons.event),
                                      // dateLabelText: 'Date',
                                      timeLabelText: "to".tr + ":",
                                      style: GoogleFonts.cairo(fontSize: 18),

                                      onChanged: (val) {
                                        print(val);
                                        endTime = val;
                                        print(endTime);
                                      },
                                      validator: (val) {
                                        print(val);
                                        return null;
                                      },
                                      onSaved: (val) => print(val),
                                    ),
                                  ),
                                ],
                              ),

                              Obx(() {
                                return CheckboxListTile(
                                  checkColor: Colors.white,
                                  title: Row(
                                    children: [
                                      CustomText(
                                        text:
                                            "You must agree to the usage policy"
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
                                height: 10.h,
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
