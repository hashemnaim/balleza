

import 'package:belleza/feature/server/app_get_cart.dart';
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';

import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartHistoryScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartHistoryScreen> {
  AppGetUser appGet = Get.find();
  GetCart getCart = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CustomText(
            text: "Order details".tr,
            fontSize: 20,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: AppColors.primaryColor),
            onPressed: () {
              navigator.pop(context);
            },
          ),
        ),
        body: Obx ( () => appGet.orderId.isEmpty
                ? Center(child: IsLoad())
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: ListView.builder(
                                itemCount:  appGet.orderId['data'].length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                      key: UniqueKey(),
                                      onDismissed:
                                          (DismissDirection direction) async {
                                        //  DBHelper.dbClint.deleteproduct(appGet.orderId[index]);
                                        getCart.deleteproduct(
                                            appGet.orderId[index]);
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
                                                    appGet
                                                        .orderId['data'][index]['product']['images'][0]['image_url'],
                                                    //    appGet.userInfoModel.value.data.photo,
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
                                                  flex: 2,
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
                                                        text: appGet
                                                            .orderId['data'][index]['product']['name']
                                                         
                                                      ),
                                                      CustomText(
                                                        text:
                                                           "${"price".tr}"" : ${ appGet.orderId['data'][index]['total_price']} ",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 50,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300]),
                                                  child: Center(
                                                    child: CustomText(
                                                      text: appGet.orderId['data'][index]['quantity']
                                                          .toString(),
                                                      fontSize: 22,
                                                    ),
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
                                      text: "${appGet.orderId['data'][0]['total_price']} \$",
                                      fontSize: 22,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: setH(10, context),
                                ),
                                CustomButton(
                                  text: "Resend the request".tr,
                                  onPress: () {
                                    List list =appGet.orderId['data'].map((e) {
                                      return {
                                        'product_id': e['product_id'],
                                        'trader_id': "1",
                                        'quantity': e['quantity'],
                                        'price': e['price'],
                                        'total_price': e['total_price'],
                                        'user_id':
                                            appGet.userProfil['data']['id'],
                                      };
                                    }).toList();

                                   ServerUser.serverUser.  getAddOrder(products: list);
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
                )));
  
  }
}
