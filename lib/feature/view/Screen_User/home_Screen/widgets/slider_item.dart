import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/style.dart';
import '../../../widgets/custom_rate.dart';

class SliderItem extends StatelessWidget {
  final String image, salonName, salonAddress;
  final double rate;
  SliderItem({this.image, this.salonName, this.salonAddress, this.rate});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
                      child: CustomerImageNetwork(
                image,
                160,
                double.infinity,
                0,
                circle: false,
              ),
          ),
          // SizedBox(
          //   height: 5.h,
          // ),
          Container(
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
                      rate: rate,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      salonAddress,
                      style: kAddressStyle,
                    ),
                    // Text(
                    //   'تقييم($rate)200',
                    //   style: kAddressStyle,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
