import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/Screen_User/more_Screen/widgets/card_rate_widget.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  AppGetUser controller = Get.find();

  // setFi() async {
  //   await getMyFavorites();
  // }

  // @override
  // void initState() {
  //   setFi();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "favorite".tr,
            color: Colors.white,
            fontSize: 18,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Obx(() {
          return controller.favoriteModel.isNotEmpty
              ? Column(children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 5.0),
                  //   child: Search(),
                  // ),
                  controller.favoriteModel['data'].length > 0
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: controller.favoriteModel['data'].length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 5),
                                child: CardRateWidget(
                                  controller.favoriteModel['data'][index]
                                      ['center']['name'],
                                  controller.favoriteModel['data'][index]
                                      ['center']['name'],
                                  controller.favoriteModel['data'][index]
                                      ['center']['logo'],
                                  controller.favoriteModel['data'][index]
                                      ['center']['rate'],
                                  id: controller.favoriteModel['data'][index]
                                      ['id'],
                                  delet: true,
                                ),
                              );
                            },
                          ),
                        )
                      : Expanded(
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "There are no favorites".tr,
                                fontSize: 22,
                              ),
                            ],
                          )),
                        )
                ])
              : Center(child: IsLoad());
        }));
  }
}
