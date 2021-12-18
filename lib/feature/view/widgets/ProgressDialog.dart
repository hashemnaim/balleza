

import 'package:belleza/feature/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'isload.dart';

class ProgressDialogUtils extends ProgressDialog {
  static ProgressDialog pr;

  ProgressDialogUtils(BuildContext context) : super(context);

  static ProgressDialog createProgressDialog(BuildContext context) {
    pr = new ProgressDialog(
      context,
      customBody: Container(
        height: 200,
        width: 200,
        child:IsLoad()
      ),
      type: ProgressDialogType.Normal,
      isDismissible: true,
    );
    pr.style(
      message: "processing_order",
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 13.0,
          fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.normal),
    );
    return pr;
  }

  void showProgressDialog() {
    if (pr != null) {
      pr.show();
    }
  }

  void hideProgressDialog() {
    if (pr != null) {
      pr.hide();
    }
  }
}
