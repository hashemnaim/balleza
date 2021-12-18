import 'package:belleza/feature/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final Color color;
  final double borderRadius;

  final Function onPress;

  CustomButton({
    @required this.onPress,
    this.text = '',
    this.color = AppColors.primaryColor,
    this.borderRadius=10,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.all(10),
      onPressed: onPress,
    color : color,
      child: CustomText(
        alignment: Alignment.center,
        text: text,
        fontSize:20.sp,
        color: Colors.white,
      ),
    );
  }
}
