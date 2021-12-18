// import 'package:belleza/feature/server/app_get_salon.dart';
// import 'package:belleza/feature/server/connectvity_service.dart';
// import 'package:belleza/feature/values/colors.dart';
// import 'package:belleza/feature/view/widgets/custom_button.dart';
// import 'package:belleza/feature/view/widgets/custom_dialoug.dart';
// import 'package:belleza/feature/view/widgets/custom_text.dart';

// import 'package:flare_flutter/flare_actor.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'forget_password_salon.dart';

// class VerifyMobileNumber extends StatelessWidget {
//   final String pinConde = '';
//   final AppGetSalon appGet = Get.find();
//   nextButtonFunction() {
//     print(pinConde);
//     print(appGet.code.toString());

//     if (this.pinConde == appGet.code.toString()) {
//       if (ConnectivityService.connectivityStatus !=
//           ConnectivityStatus.Offline) {
//         appGet.pr.show();

//         // verifyMobile(
//         //     code: pinConde,
//         //     mobile: appGet.mobileNumber,
//         //     password: appGet.password);
//       } else {
//         CustomDialougs.utils
//             .showDialoug(messageKey: 'network_error', titleKey: 'alert');
//       }
//     } else {
//       CustomDialougs.utils
//           .showDialoug(messageKey: 'not_equal_pins', titleKey: 'alert');
//     }
//   }

//   resendCode() {
//     Get.to(() => ForgetPasswordSalon());
//   }

//   // savePin(String value) {
//   //   this.pinConde = value;
//   //   print(pinConde);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: BaseAppbar(),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Container(
//                 height: MediaQuery.of(context).size.height / 3,
//                 child: this.pinConde != appGet.code.toString()
//                     ? FlareActor(
//                         "assets/animations/otp.flr",
//                         animation: "otp",
//                         fit: BoxFit.fitHeight,
//                         alignment: Alignment.center,
//                       )
//                     : FlareActor(
//                         "assets/animations/otp-verification.flr",
//                         animation: "verify-otp",
//                         fit: BoxFit.fitHeight,
//                         alignment: Alignment.center,
//                       ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               CustomText(
//                 text: translator.translate('verify_mobile_number'),
//               ),
//               CustomText(text: translator.translate('send_confirm')),
//               SizedBox(
//                 height: 25.h,
//               ),
// ////////////////////////////////////////////////////////////////////////////////
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: PinCodeTextField(
//                   length: 4,
//                   obscureText: false,
//                   animationType: AnimationType.fade,
//                   enableActiveFill: true,
//                   keyboardType: TextInputType.number,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                       fieldHeight: 75.h,
//                       fieldWidth: 65.w,
//                       activeColor: AppColors.primaryColor,
//                       activeFillColor: AppColors.primaryColor,
//                       inactiveColor: AppColors.primaryColor,
//                       inactiveFillColor: Colors.white,
//                       selectedColor: AppColors.primaryColor,
//                       selectedFillColor: AppColors.primaryColor),
//                   animationDuration: Duration(milliseconds: 300),
//                   pastedTextStyle: TextStyle(
//                     color: Colors.green.shade600,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   backgroundColor: Colors.transparent,
//                   // onCompleted: (v) {
//                   //   savePin(v);
//                   // },
//                   onChanged: (value) {},
//                   beforeTextPaste: (text) {
//                     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                     //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                     return true;
//                   },
//                   appContext: context,
//                 ),
//               ),
// ////////////////////////////////////////////////////////////////////////////////

//               SizedBox(
//                 height: 10.h,
//               ),
//               Text(
//                 translator.translate('wait_seconds'),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//               SizedBox(
//                 height: 25.h,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text(translator.translate('faild_send_code')),
//                   GestureDetector(
//                     onTap: () {
//                       resendCode();
//                     },
//                     child: CustomText(
//                       text: 'resend'.tr,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 55.h,
//               ),
//               CustomButton(
//                 text: 'next'.tr,
//                 onPress: nextButtonFunction,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
