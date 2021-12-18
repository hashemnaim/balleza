
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomDialogBox extends StatelessWidget {
  final Function onPress;
  final String titel;

  CustomDialogBox(
    this.titel, {
    Key key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      // margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.kBlack, width: 3)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomText(
            text: titel,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(22),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                  text: 'yes',
                  onPress: () {
                    Navigator.pop(context);

                    onPress();
                  }),
              CustomButton(
                  text: "cancel", onPress: () => Navigator.pop(context)),
            ],
          ),
        ],
      ),
    );
  }
}
