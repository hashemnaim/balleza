
import 'package:belleza/feature/server/app_get_cart.dart';
import 'package:belleza/feature/server/model/cart_modal.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/widgets/custom_rate.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardProduct extends StatelessWidget {
  final Map listProduct;

  const CardProduct({Key key, this.listProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Container(
        // decoration:
        //     BoxDecoration(boxShadow: <BoxShadow>[Shadows.primaryShadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Stack(
            //   children: [
            //     CustomerImageNetwork(
            //       listProduct['images'][0]['image_url'],
            //       //    appGet.userInfoModel.value.data.photo,
            //       90,
            //       200,
            //       20,
            //       circle: false,
            //       borderColor: Colors.transparent,
            //     ),
            //   ],
            // ),
            CustomText(
              text: listProduct['name'],
              fontSize: 16,
            ),
            CustomText(
              text: "${"price".tr}"" : " + listProduct['price'] + " Rial".tr,
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
            Row(
              children: [
                CustomRate(rate: listProduct['rate'].toDouble()),
              ],
            ),
            GetBuilder<GetCart>(
              init: GetCart(),
              builder: (controller) => FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                onPressed: () async {
                  await controller.addProduct(CartProductModel(
                      productName: listProduct['name'],
                      image: listProduct['images'][0]['image_url'],
                      price: listProduct['price'].toString(),
                      quantity: 1,
                      productId: listProduct['id'],
                      tradeId: listProduct['trader_id']));
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
