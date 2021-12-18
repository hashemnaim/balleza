import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/view/widgets/custom_app_bar.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../home_Screen/MarketScreen.dart/cart_history_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _ProdactScreenState createState() => _ProdactScreenState();
}

class _ProdactScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  int lastSelected = 0;
  AppGetUser appGet = Get.find();

  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "order history".tr,
        ),
        body: Obx(() => appGet.myOrder.isEmpty
            ? Center(child: IsLoad())
            : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: CustomText(
                        text: "orders".tr,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Center(child: Divider()))
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: CustomText(
                              text: "Order number".tr,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: CustomText(
                              text: "Date".tr,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: CustomText(
                              text: "total".tr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: ListView.builder(
                          itemCount: appGet.myOrder['data'].length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ServerUser.serverUser.getOrderId(appGet
                                        .myOrder['data'][index]['order_no']);
                                    Get.to(() => CartHistoryScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: CustomText(
                                            text:
                                                "#${appGet.myOrder['data'][index]['order_no']}",
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: CustomText(
                                            text:
                                                "${appGet.myOrder['data'][index]['created_at'].toString().substring(1, 10)}",
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Center(
                                          child: CustomText(
                                            text:
                                                "${appGet.myOrder['data'][index]['total_price']}",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider()
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[400]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CustomText(
                                text: appGet.myOrder['total_price'].toString(),
                                color: Color(0xFFFF006F),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: CustomText(
                                text: "Total requests".tr,
                                color: Color(0xFFFF006F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])));
  }
}
