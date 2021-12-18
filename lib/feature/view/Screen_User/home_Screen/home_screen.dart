import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/salon_list.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_slider.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/top_user_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'widgets/country_section.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = -1;
  AppGetUser appGet = Get.find();
  String z;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: DrawerCustom(),
        body: Obx(
      () => Column(
        children: [
          TopUserScreen(
            title: 'main'.tr,
            searchWidget: true,
            // height: 110.h,
          ),
          SizedBox(
            height: 35,
          ),
          appGet.categories.isEmpty
              ? Container()
              : Container(
                  height: 90.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.all(0),
                      itemCount: appGet.categories['data'].length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        bool selected = _current == index;
                        return GestureDetector(
                          onTap: () async {
                            _current = selected ? -1 : index;
                            appGet.centerFilter.value = {};
                            //      print(appGet.categories['data'][index]['id']);
                            ServerUser.serverUser.setCenterFilter(
                                appGet.categories['data'][index]['id'], 1);
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: CustomerImageNetwork(
                                      appGet.categories['data'][index]['image'],
                                      20,
                                      20,
                                      30),
                                ),
                                Container(
                                  // decoration: selected
                                  //     ? customDecoration1
                                  //     : customDecoration2,
                                  // width: 129.w,
                                  // height: 30.h,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, right: 3),
                                      child: CustomText(
                                        text: appGet.language.value == "en"
                                            ? appGet.categories['data'][index]
                                                ['title_en']
                                            : appGet.categories['data'][index]
                                                ['title'],
                                        fontSize: 12,
                                        color: selected
                                            ? AppColors.primaryColor
                                            : AppColors.kBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    floating: false,
                    pinned: false,
                    snap: false,
                    expandedHeight: 200,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomSlider(appGet.slider['data']),
                    )),
                  )
                ];
              },
              body: Column(
                children: [
                  CitiesSection(),
                  Expanded(child: SalonList()),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
