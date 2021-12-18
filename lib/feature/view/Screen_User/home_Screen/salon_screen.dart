import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:belleza/feature/view/Screen_User/auth_screen/sign_in_screen.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/reservations_new.dart';
import 'package:belleza/feature/view/widgets/custom_button.dart';
import 'package:belleza/feature/view/widgets/custom_dialog_box.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:belleza/feature/view/widgets/animationCart.dart';
import 'package:belleza/feature/view/widgets/loader_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../more_Screen/widgets/DetailsSalon.dart';
import 'widgets/top_user_screen.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SalonScreen extends StatefulWidget {
  final int id;

  const SalonScreen({Key key, this.id}) : super(key: key);
  @override
  _SalonScreenState createState() => _SalonScreenState();
}

class _SalonScreenState extends State<SalonScreen> {
  AppGetUser appGet = Get.find();
  List ind;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => appGet.centerById.isEmpty
            ? Center(child: IsLoad())
            : Column(
                children: [
                  TopUserScreen(
                    title: appGet.centerById['data']['name'],
                    searchWidget: false,
                    back: true,
                    // height: 110.h,
                  ),
                  CustomerImageNetwork(
                    appGet.centerById['data']["logo"],
                    200,
                    double.infinity,
                    0,
                    circle: false,
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView(
                      padding: EdgeInsets.all(0),
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailsSalon(
                                rate: appGet.centerById['data']['rate'],
                                salonAddress: appGet.centerById['data']
                                        ['address'] ??
                                    "" +
                                        '-' +
                                        appGet.centerById['data']['city']
                                            ['name'],
                                salonName: appGet.centerById['data']['name'],
                              ),
                              CustomText(
                                text: "Choose a service".tr,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                              appGet.categories.isEmpty
                                  ? GridView.builder(
                                      itemBuilder: (context, index) =>
                                          LoaderGif1(),
                                      physics: const BouncingScrollPhysics(),
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: 2,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                      ),
                                    )
                                  : GetBuilder<AppGetUser>(
                                      init: AppGetUser(),
                                      builder: (GetxController controller) {
                                        return GridView.builder(
                                          padding: EdgeInsets.all(0),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () async {
                                                  if (appGet.allIdCategories
                                                      .contains(
                                                          appGet.centerById[
                                                                      'data']
                                                                  ['services']
                                                              [index]['id'])) {
                                                    appGet.removeAllCategories(
                                                        index,
                                                        appGet.centerById[
                                                                    'data']
                                                                ['services']
                                                            [index]['id']);
                                                  } else {
                                                    appGet.setAllCategories(
                                                        index,
                                                        appGet.centerById[
                                                                    'data']
                                                                ['services']
                                                            [index]['id']);
                                                    appGet.setTotalePrice(int
                                                        .parse(appGet.centerById[
                                                                    'data']
                                                                ['services']
                                                            [index]['price']));
                                                    print(appGet
                                                        .totalPrice.value);
                                                  }
                                                },
                                                child: AnimationCart(
                                                    grid: true,
                                                    index: index,
                                                    count: appGet
                                                        .centerById['data']
                                                            ['services']
                                                        .length,
                                                    duration: 1500,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          // height: ScreenUtil()
                                                          //     .setHeight(65),
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: Colors.white,
                                                            boxShadow: sShadow2,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 12,
                                                              ),
                                                              CustomText(
                                                                  text: appGet.centerById['data']
                                                                              [
                                                                              'services']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'title']),
                                                              CustomText(
                                                                text: "price".tr+" : " +
                                                                    appGet.centerById['data']['services']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'price'],
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        appGet.allIdCategories.contains(
                                                                appGet.centerById[
                                                                            'data']
                                                                        [
                                                                        'services']
                                                                    [
                                                                    index]['id'])
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        4.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              8),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.grey,
                                                                          )),
                                                                  child: Icon(
                                                                    Icons.done,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 15,
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      ],
                                                    )));
                                          },
                                          physics:
                                              const BouncingScrollPhysics(),
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: appGet
                                              .centerById['data']['services']
                                              .length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 1.2,
                                                  mainAxisSpacing: 2,
                                                  crossAxisSpacing: 0.5),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      onPress: () {
                        showMaterialModalBottomSheet(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            context: context,
                            builder: (context) =>
                                ReservationsNew(id: widget.id));
                      },
                      text: 'set specific time'.tr,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
      ),
    );
  }
}
