
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/MarketScreen.dart/product_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/top_user_screen.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'WidgetMarkt/animationCart.dart';
import 'WidgetMarkt/card_product.dart';

class TraderScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TraderScreen> {
  AppGetUser appGet = Get.find();
  int id = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomAppBar(
        //   title: "the supplier",
        //   search: false,
        // ),
        body: Obx(() {
      return appGet.trader.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TopUserScreen(
                  title: 'Merchant page'.tr,
                  searchWidget: false,
                  // height: 110,
                  back: true,
                ),
                SizedBox(
                  height: setH(10, context),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                                                  child: CustomerImageNetwork(
                            appGet.trader['trader']['logo'] ?? "",
                            20,
                            20,
                            55,
                            borderColor: Colors.transparent,
                          ),
                        ),
                        CustomText(
                          text: appGet.trader['trader']['name'],
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                // appGet.traderCategory.isEmpty
                //     ? Expanded(child: Center(child: IsLoad()))
                //     : Expanded(
                //         flex: 1,
                //         child: Container(
                //           child: ListView.builder(
                //             physics: const BouncingScrollPhysics(),
                //             padding: EdgeInsets.all(0),
                //             scrollDirection: Axis.horizontal,
                //             itemCount: appGet.traderCategory['category'].length,
                //             itemBuilder: (context, index) {
                //               return Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: GestureDetector(
                //                   onTap: () {
                //                     getTraderProductCategory(
                //                         appGet.trader['trader']['id'],
                //                         appGet.traderCategory['category'][index]
                //                             ['id']);
                //                     id = index;
                //                     setState(() {});
                //                   },
                //                   child: Column(
                //                     children: [
                //                       CustomerImageNetwork(
                //                         appGet.traderCategory['category'][index]
                //                             ['image'],
                //                         //  appGet.userInfoModel.value.data.photo,
                //                         20,
                //                         20,
                //                         35,
                //                         borderColor: Colors.transparent,
                //                       ),
                //                       CustomText(
                //                         text: appGet.traderCategory['category']
                //                             [index]['name'],
                //                         color: id == index
                //                             ? AppColors.primaryColor
                //                             : Colors.black,
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "products".tr,
                          fontSize: 20,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 15, right: 15),
                          child: Container(
                            color: Colors.grey[400],
                            height: 1,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            itemCount:appGet.trader['products'].length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                ServerUser.serverUser.    getProduct(
                                        appGet.trader['products'][index]['id']);
                                    Get.to(() =>ProductScreen(
                                      list: appGet.trader['data'][id]
                                              ['products'][index]['images'][0]
                                          ['image_url'],
                                    ));
                                  },
                                  child: AnimationCart(
                                      index: index,
                                      count: appGet.trader['products'].length,
                                      duration: 300,
                                      child: Container(
                                          height: 200,
                                          width: 200,
                                          child: CardProduct(
                                              listProduct:
                                                  appGet.trader['products'][index])
                                                  )
                                                  ));
                            },
                          ),
                        ),
                      )
              ],
            )
          : Center(child: IsLoad());
    }));
  }
}
