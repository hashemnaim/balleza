import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

import 'package:belleza/feature/values/style.dart';



class NotificationItem extends StatelessWidget {

  final String userName,title ,image ;
  NotificationItem({ this.userName, this.title, this.image});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(60),
              //   child: Image.asset(
              //     'assets/images/salon2.png',
              //     fit: BoxFit.fill,
              //     height: 63.h,
              //     width: 63.w,
              //   ),
              // ),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'حنان محمد محسون',
                      style: kNameTextStyle,
                    ),
                    Text(
                      'منذ يومين',
                      style: kDayTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding:  EdgeInsets.only(right: 65.w),
          child: Divider(
            color: Color(0xffB8B6B6),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
