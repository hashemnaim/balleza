import 'package:belleza/feature/values/colors.dart';
import 'package:flutter/material.dart';

class IsLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 20,
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
