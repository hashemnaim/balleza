import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/view/Screen_Salon/widgets/salon_category_list.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/MarketScreen.dart/product_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/product_item.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/top_user_screen.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketScreen extends StatelessWidget {
  final AppGetUser appGet = Get.find();
  final String image = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopUserScreen(
            title: 'products'.tr,
            searchWidget: true,
            // height: 110.h,
          ),
         SizedBox(
            height: 35,
          ),
          Obx(
            () => appGet.productCategories.isEmpty
                ? Container()
                : SalonCategoryList(
                  itemCategory: appGet.productCategories['categories'],
                ),
          ),
          Obx(
            () => appGet.topRated.isEmpty
                ? Expanded(child: IsLoad())
                : appGet.marktCategories.isEmpty
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GridView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: appGet.topRated['data'].length,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    ServerUser.serverUser.getProduct(
                                        appGet.topRated['data'][index]['id']);

                                    Get.to(() => ProductScreen(
                                          list: appGet.product,
                                          image: appGet.topRated['data'][index]
                                              ['images'][0]['image_url'],
                                        ));
                                  },
                                  child: ProductItem(
                                    name: appGet.topRated['data'][index]
                                        ['name'],
                                    imageUrl: appGet.topRated['data'][index]
                                        ['images'][0]['image_url'],
                                    price: appGet.topRated['data'][index]
                                        ['price'],
                                    idProduct: appGet.topRated['data'][index]
                                        ['id'],
                                    idTrder: appGet.topRated['data'][index]
                                        ['trader_id'],
                                  ),
                                );
                              }),
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GridView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              primary: false,
                              itemCount:
                                  appGet.marktCategories['products'].length,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                mainAxisSpacing: 1,
                                crossAxisSpacing: 1,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    ServerUser.serverUser.getProduct(
                                        appGet.marktCategories['products']
                                            [index]['id']);
                                    Get.to(() => ProductScreen(
                                          list: appGet.product.isEmpty
                                              ? {}
                                              : appGet.product['data'],
                                          image: appGet.marktCategories['data']
                                              [index]['images'][0]['image_url'],
                                        ));
                                  },
                                  child: ProductItem(
                                    name: appGet.marktCategories['products']
                                        [index]['name'],
                                    imageUrl: appGet.marktCategories['products']
                                        [index]['images'][0]['image_url'],
                                    price: appGet.marktCategories['products']
                                        [index]['price'],
                                    idProduct:
                                        appGet.marktCategories['products']
                                            [index]['id'],
                                    idTrder: appGet.marktCategories['products']
                                        [index]['trader_id'],
                                  ),
                                );
                              }),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
