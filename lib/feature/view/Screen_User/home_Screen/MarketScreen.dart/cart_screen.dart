
import 'package:belleza/feature/server/app_get_cart.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AppGetUser appGet = Get.find();
  GetCart getCart = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
          child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: CustomText(
              text: "My purchases".tr,
              fontSize: 20,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
              ),
              onPressed: () {
                navigator.pop(context);
              },
            ),
          ),
          body: GetBuilder<GetCart>(
              init: GetCart(),
              builder: (controller) => controller.cartProductModel.isEmpty
                  ? Center(child: CustomText(text: "no products".tr))
                  : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: ListView.builder(
                                  itemCount: controller.cartProductModel.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                        key: UniqueKey(),
                                        onDismissed:
                                            (DismissDirection direction) async {
                                          //  DBHelper.dbClint.deleteproduct(controller.cartProductModel[index]);
                                          getCart.deleteproduct(
                                              controller.cartProductModel[index]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6),
                                          child: Container(
                                              height: setH(90, context),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 6)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(15)),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: CustomerImageNetwork(
                                                      controller
                                                          .cartProductModel[index]
                                                          .image,
                                                      setH(90, context),
                                                      setW(200, context),
                                                      20,
                                                      circle: false,
                                                      borderColor:
                                                          Colors.transparent,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: setW(10, context),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: setH(4, context),
                                                        ),
                                                        CustomText(
                                                          text: controller
                                                              .cartProductModel[
                                                                  index]
                                                              .productName,
                                                        ),
                                                        CustomText(
                                                          text: "price".tr+
                                                              " : ${controller.cartProductModel[index].quantity * int.parse(controller.cartProductModel[index].price)} ",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    height: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey[300]),
                                                    child: Column(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .incrementCount(
                                                                      index);
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 22,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: CustomText(
                                                            text: controller
                                                                .cartProductModel[
                                                                    index]
                                                                .quantity
                                                                .toString(),
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .decrementCount(
                                                                      index);
                                                            },
                                                            child: Icon(
                                                              Icons.remove,
                                                              size: 22,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ));
                                    // );
                                  }),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "total".tr,
                                        fontSize: 22,
                                      ),
                                      CustomText(
                                        text: "${controller.totalPrice} "+'Rial'.tr,
                                        fontSize: 22,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: setH(10, context),
                                  ),
                                  CustomButton(
                                    text: "Buy now".tr,
                                    onPress: () {
                                      List list = controller.cartProductModel.map((e) {
                                        return {
                                          'product_id': e.productId,
                                          'trader_id': e.tradeId,
                                          'quantity': e.quantity,
                                          'price': e.price,
                                          'total_price': controller.totalPrice,
                                          'user_id':appGet.userProfil['data']['id'],
                                        };
                                      }).toList();

                                 ServerUser.serverUser.     getAddOrder(products: list);
                                    },
                                  ),
                                  SizedBox(
                                    height: setH(20, context),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ))),
    );
  }
}
