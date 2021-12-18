import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:belleza/feature/values/style.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../widgets/custom_rate.dart';

class DetailsSalon extends StatelessWidget {
  final String salonName, salonAddress;
  final num rate;

  DetailsSalon({this.salonName, this.salonAddress, this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                salonName,
                style: kSalonTextStyle,
              ),
              CustomRate(
                rate: rate.toDouble(),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                      text:
                salonAddress??"",
                fontSize: 12,
              ),
              // GestureDetector(
              //   onTap: () {
              //     showMaterialModalBottomSheet(
              //         elevation: 2,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             topRight: Radius.circular(10),
              //           ),
              //         ),
              //         context: context,
              //         builder: (context) => Padding(
              //               padding: const EdgeInsets.all(10.0),
              //               child: CommentList(),
              //             ));
              //   },
              //   child: Container(
              //       // height: 30.h,
              //       // width: 110.h,
              //       decoration: BoxDecoration(
              //           color: Colors.grey[100],
              //           borderRadius: BorderRadius.circular(10)),
              //       child: Center(
              //           child: CustomText(
              //         text: 'تقيم العملاء($rate)',
              //         fontSize: 10,
              //       )
              //       )
              //       ),
              // ),
          
            ],
          ),
      
        ],
      ),
    );
  }
}
