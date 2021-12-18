import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/Screen_User/more_Screen/widgets/DetailsSalon.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/salon_screen.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum WhyFarther { range, rate, price, outService }

class SearchScreen extends StatefulWidget {
  // searchOnFavouriteTextField(String text) {
  //   searchOnFavourite(text);
  // }

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final AppGetUser appGet = Get.find();

  final List<String> _tabs = ['Salons'.tr, 'products'.tr];

  int type=0;
  var selection = "";
  var text = "";
//  @override
//   void initState() {
//     super.initState();

// ServerUser.serverUser.getSearch(
//                             "", "Center", "");
//   }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: PopupMenuButton<WhyFarther>(
            icon: Icon(
              Icons.filter_list,
              color: Colors.black54,
              size: 35,
            ),
            onSelected: (WhyFarther result) {
              setState(() {
                selection = result.toString() ?? "";
                    type == 0
                  ? ServerUser.serverUser.getSearch(text, "Center", selection)
                  : ServerUser.serverUser.getSearch(text, "Product", selection);
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
               PopupMenuItem<WhyFarther>(
                value: WhyFarther.range,
                child: CustomText(text:'the closest'.tr),
              ),
               PopupMenuItem<WhyFarther>(
                value: WhyFarther.range,
                child: CustomText(text:'The highest rated'.tr),
              ),
               PopupMenuItem<WhyFarther>(
                value: WhyFarther.price,
                child: CustomText(text:'The lowest pricet'.tr),
              ),
              PopupMenuItem<WhyFarther>(
                value: WhyFarther.outService,
                child: CustomText(text:"Home service".tr),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon:
                  Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          centerTitle: true,
          title: Container(
            height: 50,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        // offset: Offset(0.0, 1),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Colors.black12.withOpacity(0.20))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                  textAlign: TextAlign.right,
                  onChanged: (value) async {
                    print(selection);
                    value = value;
                    type == 0
                        ? ServerUser.serverUser
                            .getSearch(value, "Center", selection)
                        : ServerUser.serverUser
                            .getSearch(value, "Product", selection);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      filled: false,
                      fillColor: Colors.white,
                      hintText: "search".tr,
                      prefixIcon: Icon(Icons.search),
                      hintStyle: TextStyle(
                          height: 1,
                          color: Colors.grey,
                          fontFamily: "Cairo",
                          fontSize: 16),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          gapPadding: 0.5,
                          borderRadius: BorderRadius.circular(10)))),
            ),
          ),
          bottom: TabBar(
            labelColor: AppColors.kBlack,
            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
            indicatorColor: AppColors.primaryColor,
            onTap: (value) {
              type = value;
              print(value);
              appGet.search.clear();
              type == 0
                  ? ServerUser.serverUser.getSearch(text, "Center", selection)
                  : ServerUser.serverUser.getSearch(text, "Product", selection);
              setState(() {});
            },
          ),
        ),
        body: TabBarView(
          children: _tabs.map((String name) {
            return Builder(
              builder: (BuildContext context) {
                return Obx(
                  () => appGet.search.isNotEmpty
                      ? Container(
                          child: ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: appGet.search['data'].length,
                              //   scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return appGet.search['data'].length == 0
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            size: 100,
                                            color: AppColors.primaryColor,
                                          ),
                                          CustomText(
                                              text: "There are no results for the search".tr),
                                        ],
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          ServerUser.serverUser.setCenterById(
                                              appGet.search['data'][index]
                                                  ['id']);
                                          kNavigatorPush(
                                              context,
                                              SalonScreen(
                                                  id: appGet.search['data']
                                                      [index]['id']));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                            
                                           type == 0?   Expanded(
                                                child:
                                                 CustomerImageNetwork( 
                                                  appGet.search['data'][index]
                                                      ['logo'],
                                                  20,
                                                  20,
                                                  35,
                                                ),
                                              ):Expanded(
                                                child:
                                                 CustomerImageNetwork( 
                                               appGet.search['data'][index]
                                                      ['images'][0]['image_url'],
                                                  20,
                                                  20,
                                                  35,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                                                              child: DetailsSalon(
                                                  salonName: appGet.search['data']
                                                      [index]['name'],
                                                  salonAddress: "",
                                                  rate: appGet.search['data']
                                                      [index]['rate'],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 100,
                              color: AppColors.primaryColor,
                            ),
                            // IsLoad(),
                            // CustomText(text: "لا يوجد نتائج للبحث"),
                          ],
                        ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
