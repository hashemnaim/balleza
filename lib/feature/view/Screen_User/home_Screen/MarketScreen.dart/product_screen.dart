import 'package:belleza/feature/server/app_get_cart.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/model/cart_modal.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/MarketScreen.dart/trader_screen.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_rate.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  final Map list;

  final String image;

  ProductScreen({Key key, this.image, this.list}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
    return Obx(() {
      return widget.list.isEmpty
          ? Scaffold(body: Center(child: Container(child: IsLoad())))
          : Scaffold(
              body: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Expanded(
                      flex: 2,
                      child: Hero(
                        tag: widget.image,
                        child: Container(
                          child: Stack(
                            children: [
                              CustomerImageNetwork(
                                widget.image,
                                400,
                                double.infinity,
                                20,
                                circle: false,
                                borderColor: Colors.transparent,
                              ),
                              Positioned(
                                  right: 10,
                                  top: 25,
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          height: 60,
                                          width: 60,
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            size: 25,
                                          )))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomRate(
                                  rate:
                                      widget.list['data']['rate'].toDouble() ??
                                          "",
                                ),
                                CustomText(text: widget.list['data']['name']),
                              ],
                            ),
                            CustomText(
                                    text: "price".tr+ " : " +
                                        widget.list['data']['price'] +
                                        " Rial".tr) ??
                                "",
                            CustomText(
                              text: widget.list['data']['description'] ?? "",
                            ),
                            CustomText(
                              text: "the supplier".tr,
                              fontSize: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                // getTraderCategory(
                                //     appGet.product['data']['trader']["id"]);
                                ServerUser.serverUser.getTrader(
                                    widget.list['data']['trader_id']);
                                Get.to(() => TraderScreen());
                              },
                              child: Row(
                                children: [
                                  CustomerImageNetwork(
                                    widget.list['data']['trader']["logo"] ?? "",
                                    20,
                                    20,
                                    30,
                                  ),
                                  SizedBox(
                                    width: setW(14, context),
                                  ),
                                  CustomText(
                                    text: widget.list['data']['trader']['name'],
                                    fontSize: 20,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: setH(20, context),
                            ),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.add,
                                                size: 28,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                incrementCount();
                                              }),
                                          Text(
                                            count.toString(),
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.remove,
                                                size: 28,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                decrementCount();
                                              })
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GetBuilder<GetCart>(
                                    init: GetCart(),
                                    builder: (controller) => FlatButton(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      onPressed: () async {
                                        await controller.addProduct(
                                            CartProductModel(
                                                productName: appGet
                                                    .product['data']['name'],
                                                image: widget.image,
                                                price: appGet.product['data']
                                                        ['price']
                                                    .toString(),
                                                quantity: count,
                                                tradeId: appGet.product['data']
                                                    ["trader_id"],
                                                productId: appGet
                                                    .product['data']['id']));
                                        Get.snackbar(
                                            "It has been added to the basket".tr, "thank".tr);
                                      },
                                      color: AppColors.primaryColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            alignment: Alignment.center,
                                            text: "add to cart".tr,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
