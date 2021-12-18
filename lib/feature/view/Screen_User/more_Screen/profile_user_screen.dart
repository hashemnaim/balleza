import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_auth.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/top_user_screen.dart';
import 'package:belleza/feature/view/widgets/custom_filed.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUser extends StatefulWidget {
  String name;
  String mobile;
  String email;
  String addrees;

  ProfileUser({Key key, this.name, this.mobile, this.email, this.addrees})
      : super(key: key);
  @override
  _ProfileSalonState createState() => _ProfileSalonState();
}

class _ProfileSalonState extends State<ProfileUser> {
  final AppGetUser appGet = Get.find();

  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    print(widget.name);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // endDrawer: DrawerCustom(),
      body: Column(
        children: [
          TopUserScreen(
            title: 'Profile personly'.tr,
            searchWidget: false,
            back: true,
          ),
          Obx(
            () => appGet.userProfil.isEmpty
                ? Expanded(child: Center(child: IsLoad()))
                : Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w),
                    child: Container(
                      child: Column(
                        children: [
                          // SizedBox(
                          //   height: 50.h,
                          // ),
                          Center(
                            child: Stack(
                              children: [
                                GetBuilder<AppGetSalon>(
                                  init: AppGetSalon(),
                                  builder: (controller) =>
                                      controller.imageFile == null
                                          ? Center(
                                              child: CustomerImageNetwork(
                                                  appGet.userProfil['data']
                                                      ['image'],
                                                  20,
                                                  2,
                                                  80),
                                            )
                                          : CircleAvatar(
                                              radius: 80,
                                              backgroundImage: ExactAssetImage(
                                                controller.imageFile.path,
                                              )),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 150,
                                  child: GestureDetector(
                                    onTap: () async {
                                      showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoActionSheet(
                                              title: CustomText(
                                                text: "Download".tr,
                                                color: Colors.grey,
                                              ),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child:
                                                            CupertinoActionSheetAction(
                                                          child: Icon(
                                                            Icons.camera,
                                                            size: 30,
                                                            color: Colors.red,
                                                          ),
                                                          // isDefaultAction: true,
                                                          onPressed: () async {
                                                            appGet.getImage(
                                                                ImageSource
                                                                    .camera);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          CupertinoActionSheetAction(
                                                        child: Icon(
                                                          Icons.image,
                                                          size: 35,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () async {
                                                          appGet.getImage(
                                                              ImageSource
                                                                  .gallery);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                              cancelButton:
                                                  CupertinoActionSheetAction(
                                                child:
                                                    CustomText(text: "cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 30.h,
                                      width: 30.w,
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF5F5F5),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xff171717),
                                          )),
                                      child: SvgPicture.asset(
                                        'assets/svg/addImage.svg',
                                        height: 25.h,
                                        width: 25.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: GestureDetector(
                              onTap: () {
                                enabled = !enabled;
                                print(enabled);
                                setState(() {});
                                if (enabled == false) {
                                  ServerAuth.serverAuth.editProfile(
                                      widget.name,
                                      widget.mobile,
                                      widget.addrees,
                                      widget.email);
                                  enabled = enabled;
                                  setState(() {});
                                }
                              },
                              child: enabled == false
                                  ? CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Colors.green,
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                CustomText(
                                  text: "name".tr+" :  ",
                                  fontSize: 18,
                                ),
                                Expanded(
                                  child: CustomTextFiled(
                                      init: widget.name,
                                      enabled: enabled,
                                      onChanged: (value) {
                                        widget.name = value;
                                        print(widget.name);
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                CustomText(
                                  text: "email".tr+" : ",
                                  fontSize: 18,
                                ),
                                Expanded(
                                    child: CustomTextFiled(
                                        init: widget.email,
                                        enabled: enabled,
                                        onChanged: (value) {
                                          widget.email = value;
                                          print(widget.email);
                                        })),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                CustomText(
                                  text: "mobile".tr+" : ",
                                  fontSize: 18,
                                ),
                                Expanded(
                                    child: CustomTextFiled(
                                        init: widget.mobile,
                                        enabled: enabled,
                                        onChanged: (value) {
                                          widget.mobile = value;
                                          print(widget.mobile);
                                        })),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              children: [
                                CustomText(
                                  text: "address".tr+" : ",
                                  fontSize: 18,
                                ),
                                Expanded(
                                    child: CustomTextFiled(
                                        init: widget.addrees,
                                        enabled: enabled,
                                        onChanged: (value) {
                                          widget.addrees = value;
                                          print(widget.addrees);
                                        })),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
