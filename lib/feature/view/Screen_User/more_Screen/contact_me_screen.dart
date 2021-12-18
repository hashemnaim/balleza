import 'package:belleza/feature/server/server_salon.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/top_salon_screen.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Screen_User/more_Screen/widgets/contact_text_form_field.dart';
class ContactMeScreen extends StatelessWidget {

  String name;
  String title;
  String phoneNumber;
  String body;
  saveFirstName(String value) {
    this.name = value;
    print(name);
  }

  saveTitle(String value) {
    this.title = value;
        print(title);

  }
   saveBody(String value) {
    this.body = value;
  }

  savePhaoneNumber( String value) {

    this.phoneNumber = value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
          children: [
            TopSalonScreen(
              title: 'Connect with us'.tr,
              searchWidget: false,
              back: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 37.h,
                  ),
                  CustomTextFormField2(
                    minHeight: 37.h,
                    hintText: 'name'.tr,
                    onChange: saveFirstName,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  CustomTextFormField2(
                    minHeight: 37.h,
                    hintText: 'mobile'.tr,
                    textInputType: TextInputType.number,
                    onChange:savePhaoneNumber ,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                   CustomTextFormField2(
                    minHeight: 32.h,
                    hintText: 'address'.tr,
                    onChange: saveTitle,
                  ),
                     SizedBox(
                    height: 13.h,
                  ),
                   CustomTextFormField2(
                    minHeight: 150.h,
                    hintText: 'the details'.tr,onChange: saveBody,

                  ),
                   SizedBox(
                    height: 53.h,
                  ),
                 
                 
                  CustomButton(
                    // height: 37.h,
                    onPress: () {
                      ServerSalon.serverSalon.setContactUs(name,phoneNumber , title, body);
                    },
                    // textStyle: kBtnTextStyle2,
                    text: 'send'.tr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
