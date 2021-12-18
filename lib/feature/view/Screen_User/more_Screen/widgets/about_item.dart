import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
class AboutItem extends StatelessWidget {
  final String title ,subTitle ;
  AboutItem({ this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text:
            title,
          ),
          SizedBox(
            height: 8.h,
          ),
          CustomText(text:
            subTitle,
          ),
        ],
      ),
    );
  }
}
