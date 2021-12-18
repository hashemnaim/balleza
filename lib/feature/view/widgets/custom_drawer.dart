// import 'package:belleza/feature/server/AppGet.dart';
// import 'package:belleza/feature/values/constant.dart';
// import 'package:belleza/feature/view/Screen_User/more_Screen/about_screen.dart';
// import 'package:belleza/feature/view/Screen_User/more_Screen/contact_me_screen.dart';
// import 'package:belleza/feature/view/Screen_User/more_Screen/notificationScreen.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:belleza/feature/values/colors.dart';
// import 'package:belleza/feature/values/shadow.dart';
// import 'package:belleza/feature/values/style.dart';
// import 'package:belleza/feature/view/Screen_User/main_screen.dart';

// class DrawerCustom extends StatelessWidget {
//  final AppGet appGet = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 255.w,
//       child: Drawer(
//         elevation: 0,
//         child: Container(
//           color: AppColors.primaryColor,
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 40.h,
//               ),
//               DrawerImage(
//                 onTapCamera: null,
//                 image: 'assets/images/salon2.png',
//               ),
//               SizedBox(
//                 height: 15.h,
//               ),
//               Text(
//                 'حنان حسين منصور ',
//                 style: kDrawerTextStyle,
//               ),
//               DrawerItem(
//                 onTap: () {
//                   appGet.setindexNav(0);
//                   kNavigatorPush(context, MainUserScreen());
//                 },
//                 text: 'الرئيسية ',
//               ),
//               DrawerItem(
//                 onTap: () {
//                   appGet.setindexNav(0);
//                   kNavigatorPush(context, MainUserScreen());
//                 },
//                 text: 'قائمة الصالونات',
//               ),
//               DrawerItem(
//                 onTap: () {
//                   appGet.setindexNav(1);
//                   kNavigatorPush(context, MainUserScreen());
//                 },
//                 text: 'قائمة حجوزاتي',
//               ),
//               DrawerItem(
//                 onTap: () {
//                   Get.to(() =>NotificationScreen());
//                 },
//                 text: 'الإشعارات',
//               ),
//               DrawerItem(
//                 onTap: () => kNavigatorPush(context, AboutScreen()),
//                 text: 'حول التطبيق',
//               ),
//               DrawerItem(
//                 onTap: () => kNavigatorPush(context, ContactMeScreen()),
//                 text: 'اتصل بنا',
//               ),
//               DrawerItem(
//                 onTap: null,
//                 text: 'مشاركة التطبيق',
//               ),
//               DrawerItem(
//                 onTap: null,
//                 text: 'خروج',
//                 out: true,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DrawerImage extends StatelessWidget {
//   final Function onTapCamera;

//   final String image;

//   DrawerImage({this.onTapCamera, this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 125.h,
//       width: 125.w,
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(60),
//               boxShadow: sShadow3,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(60),
//               child: Image.asset(
//                 image,
//                 fit: BoxFit.fill,
//                 height: 125.h,
//                 width: 125.w,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: GestureDetector(
//                 onTap: onTapCamera,
//                 child: Container(
//                     height: 32.h,
//                     width: 32.h,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.kBlack,
//                     ),
//                     child: Icon(
//                       FontAwesomeIcons.camera,
//                       color: Colors.white,
//                       size: 15,
//                     )),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


// class DrawerItem extends StatelessWidget {
//   final String text;

//   final bool out;
//   final Function onTap;

//   DrawerItem({@required this.text, this.out =false, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
//       child: GestureDetector(
//         onTap:onTap ,
//         child: Row(
//           children: [
//             Container(
//               color:  AppColors.kPink2,
//               height: 34.h,
//               width: 5,
//             ),
//             SizedBox(
//               width: 25,
//             ),
//             Text(text, style:out? kDrawerTextStyle.copyWith(
//               color: Color(0xff171717),
//             ):kDrawerTextStyle),
//           ],
//         ),
//       ),
//     );
//   }
// }
