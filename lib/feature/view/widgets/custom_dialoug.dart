import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomDialougs {
  CustomDialougs._();
  // AppGet controller = Get.find();
  static CustomDialougs utils = CustomDialougs._();
  Function du = () => Get.back();

  
  showDialoug({String titleKey, String messageKey, Function fun}) {
    // controller.pr.hide();
    Get.defaultDialog(
        confirm: CupertinoButton(
            child: Text('Ok'),
            onPressed: fun != null ? () => fun() : () => du()),
        middleText: messageKey,
        title: titleKey);
  }

  showSackbar({String titleKey, String messageKey}) {
    Get.snackbar(
      titleKey,
      messageKey,
      duration: Duration(seconds: 3),
    );
  }
}
