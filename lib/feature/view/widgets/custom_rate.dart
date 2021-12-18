import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

class CustomRate extends StatelessWidget {
  final double rate;
  CustomRate({this.rate=0.0});
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Directionality(
        textDirection:TextDirection.ltr ,
        child: RatingBar.readOnly(
          size: 12,
          initialRating:rate.toDouble(),
          isHalfAllowed: true,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          emptyIcon: Icons.star,
          emptyColor: Color(0xffAFADA4),
          halfFilledColor:Color(0xffFFC107),
          filledColor:Color(0xffFFC107),
        ),
      ),
    );
  }
}