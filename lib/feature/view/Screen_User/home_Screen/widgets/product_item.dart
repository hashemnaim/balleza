import 'package:belleza/feature/server/app_get_cart.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/model/cart_modal.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/Screen_User/auth_screen/sign_in_screen.dart';
import 'package:belleza/feature/view/widgets/custom_dialog_box.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductItem extends StatefulWidget {
  final String imageUrl, price, name, idTrder;
  final int idProduct;
  ProductItem(
      {this.imageUrl, this.price, this.name, this.idProduct, this.idTrder});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  AppGetUser appGet = Get.find();

  int count = 1;

  incrementCount() {
    setState(() {
      count++;
    });
  }

  decrementCount() {
    setState(() {
      if (count > 1) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 260.h,
        margin: EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: CustomerImageNetwork(
                  widget.imageUrl,
                  158,
                  158,
                  0,
                  circle: false,
                )),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  CustomText(
                    text: widget.name,
                  ),
                  CustomText(
                    text: '${widget.price} درهم',
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GetBuilder<GetCart>(
                init: GetCart(),
                builder: (controller) => FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  // padding: EdgeInsets.all(10),
                  onPressed: () async {
                    if (appGet.userProfil["data"]['mobile'] == "0098765425") {
                      showDialog(
                          context: context,
                          builder: (context) => CustomDialogBox(
                                "You must be logged in".tr,
                                onPress: () {
                                  Get.to(SignInScreenUser());
                                },
                              ));
                    } else {
                      await controller.addProduct(CartProductModel(
                          productName: widget.name,
                          image: widget.imageUrl,
                          price: widget.price,
                          quantity: 1,
                          tradeId: widget.idTrder,
                          productId: widget.idProduct));
                      Get.snackbar("It has been added to the basket".tr, "thank".tr);
                    }
                  },
                  color: AppColors.primaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        alignment: Alignment.center,
                        text: "add to cart".tr,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
