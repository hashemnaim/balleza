import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/MarketScreen.dart/product_screen.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'WidgetMarkt/animationCart.dart';
import 'WidgetMarkt/card_product.dart';

class CatagtyScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CatagtyScreen> {
  AppGetUser appGet = Get.find();
  int id = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: CustomAppBar(
        //   title: "الاصناف",
        //   search: false,
        // ),
        body: Obx(() {
      return appGet.trader.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: setH(50, context),
                ),
                appGet.traderCategory.isEmpty
                    ? Expanded(child: Center(child: IsLoad()))
                    : Expanded(
                        flex: 1,
                        child: Container(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            itemCount: appGet.traderCategory['category'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    ServerUser.serverUser
                                        .getTraderProductCategory(
                                            appGet.trader['trader']['id'],
                                            appGet.traderCategory['category']
                                                [index]['id']);
                                    id = index;
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      CustomerImageNetwork(
                                        appGet.traderCategory['category'][index]
                                            ['image'],
                                        //  appGet.userInfoModel.value.data.photo,
                                        20,
                                        20,
                                        35,
                                        borderColor: Colors.transparent,
                                      ),
                                      CustomText(
                                        text: appGet.traderCategory['category']
                                            [index]['name'],
                                        color: id == index
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "ListProducts".tr,
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
                appGet.traderProductCategory.isEmpty
                    ? Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            itemCount: appGet.trader['products'].length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                    ServerUser.serverUser.getProduct(
                                        appGet.trader['products'][index]['id']);
                                    Get.to(() => ProductScreen(
                                          list: appGet.trader['data'][id]
                                                  ['products'][index]['images']
                                              [0]['image_url'],
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
                                                  appGet.trader['products']
                                                      [index]))));
                            },
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                appGet.traderProductCategory['products'].length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                    ServerUser.serverUser.getProduct(
                                        appGet.trader['products'][index]['id']);
                                    Get.to(() => ProductScreen(
                                          list: appGet.trader['data'][id]
                                                  ['products'][index]['images']
                                              [0]['image_url'],
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
                                                  appGet.traderProductCategory[
                                                      'products'][index]))));
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
