import 'package:belleza/feature/server/app_get_salon.dart';
import 'package:belleza/feature/values/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileNumberTextField extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();
  final Function fun;
  final String content;
  MobileNumberTextField({this.fun, this.content}) {
    if (content != null) {
      editingController.text = content;
    }
  }
  final AppGetSalon appGet = Get.find();
  final String countryCode = '971+';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            // height: 55.h,
            child: TextFormField(
              // controller: editingController,
              // maxLength: 9,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                  size: 24.0,
                ),
                suffixText: countryCode,
                suffixStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.grayText, width: 2.0.w),
                  borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                ),
                labelText: 'mobile'.tr,
                labelStyle: GoogleFonts.cairo(
                  color: Colors.grey,
                  fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
                ),
              ),
              onSaved: (value) {
                fun(this.countryCode, value);
              },
              validator: (val) {
                Pattern pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                RegExp regex = new RegExp(pattern);
                if (val.isEmpty) {
                  return "Mobile number must be entered".tr;
                } else if (!regex.hasMatch(val)) {
                  return "Mobile number must be entered".tr;
                }
                return null;
              },
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 4.0),
        //   child: CustomText(text:"971+",fontSize: 20,),
        // )
        // CountryCodePicker(
        //   countryFilter: [
        //     '',
        //   ],

        //   // onChanged: (value) {
        //   //   this.countryCode = value.dialCode.replaceAll('+', '');
        //   //   logger.e('$countryCode');
        //   // },
        //   showCountryOnly: false,
        //   showOnlyCountryWhenClosed: false,
        //   alignLeft: false,
        // ),
      ],
    );
  }
}
