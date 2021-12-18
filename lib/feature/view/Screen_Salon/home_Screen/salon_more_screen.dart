import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/helper/s_helpar.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/Screen_Salon/home_Screen/salon_profile_screen.dart';
import 'package:belleza/completeSignUp1.dart';
import 'package:belleza/feature/view/Screen_User/more_Screen/contact_me_screen.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileSalonScreen extends StatelessWidget {

  final AppGetUser userGet = Get.find();
  final AppGetSalon appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
          appGet.salonProfil.isEmpty? Center(child: IsLoad()):  Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                CustomerImageNetwork(
                    appGet.salonProfil['data']['logo'], 20, 2, 50),
                Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      text: appGet.salonProfil['data']['name'],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: AppColors.kBorder2,
            ),
            ContainerCart(
              // height: 250,
              child: Column(
                children: [
                  ListTileProfile(
                    onTap: () {
                      Get.to(() => ProfileSalon(name: appGet.salonProfil['data']['name'],email: appGet.salonProfil['data']['email']??"",mobile: appGet.salonProfil['data']['mobile']??"",addrees: appGet.salonProfil['data']['address']??"",));                   },
                    title: 'Account Information'.tr,
                    image: Icon(
                      Icons.person_outline,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            ContainerCart(
              // height: 320,
              child: Column(
                children: [
                  ListTileProfile(
                    onTap: () => Get.to(() => ContactMeScreen()),
                    title: 'Support and support'.tr,
                    image: Icon(
                      Icons.contact_support,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColors.kBorder2,
                  ),
                  // ListTileProfile(
                  //     onTap: () => Get.to(() => AboutScreen()),
                  //     title: 'من نحن',
                  //     image: Icon(
                  //       Icons.info_outline,
                  //       color: AppColors.primaryColor,
                  //       size: 30,
                  //     )),
                  Divider(
                    thickness: 1,
                    color: AppColors.kBorder2,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.share,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    title: CustomText(text:
                      'Share the app'.tr,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kPink2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),


             ContainerCart(
              child: GestureDetector(
                child: ListTile(
                  onTap: () async {
       
                  },
                  leading: Icon(
                    Icons.language,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  title: CustomText(
                    text: "Language".tr,
                    fontSize: 16,
                  ),
                  trailing: Container(
                    child: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: CustomText(
                              text: ("العربية"),
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                            value: 'ar',
                          ),
                          DropdownMenuItem(
                            child: CustomText(
                              text: ("English"),
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                            value: 'en',
                          ),
                        ],
                        value: userGet.language.value,
                        onChanged: (value) async {
                          
                          userGet.language.value = value;
                          await SHelper.sHelper
                              .addNew("Lang", userGet.language.value);
                          Get.updateLocale(Locale(userGet.language.value));
                        }),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            ContainerCart(
              child: GestureDetector(
                child: ListTile(
                  onTap: () async {
                    await SHelper.sHelper.clearSp();
                    appGet.token = null;
                    Get.offAll(() => CompleteSignUp1());
                  },
                  leading: Icon(
                    Icons.login,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  title: CustomText(text:
                    'logout'.tr,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////customWidget
class ListTileProfile extends StatelessWidget {
  final Widget image;
  final String title;
  final Widget route;
  final Function onTap;
  final Color kBlack = Color(0xff242424);
  final TextStyle kProfile = TextStyle(
    fontSize: 14,
    color: Color(0xff242424),
  );

  ListTileProfile({this.image, this.title, this.route, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: image,
        title: CustomText(
          text: title,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.kPink2,
        ),
        onTap: onTap);
  }
}

class ContainerCart extends StatelessWidget {
  final Widget child;

  ContainerCart({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
      ),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 2, offset: Offset(2, 2), color: Color(0xffEDF1F7)),
            BoxShadow(
                blurRadius: 2, offset: Offset(-2, 0), color: Color(0xffEDF1F7)),
          ],
          borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
