import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/isload.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../salon_screen.dart';
import '../../more_Screen/widgets/DetailsSalon.dart';

class SalonList extends StatelessWidget {
  final AppGetUser appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => appGet.centerFilter.isEmpty
          ? Center(child: IsLoad())
          : Container(
              child: RefreshIndicator(
                onRefresh: () async {

                  return ServerUser.serverUser.getTopRated();
                },
                child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: appGet.centerFilter['data'].length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          ServerUser.serverUser.setCenterById(
                              appGet.centerFilter['data'][index]['id']);
                          kNavigatorPush(
                              context,
                              SalonScreen(
                                  id: appGet.centerFilter['data'][index]
                                      ['id']));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CustomerImageNetwork(
                                appGet.centerFilter['data'][index]['logo'],
                                20,
                                20,
                                35,
                              ),
                              Expanded(
                                child: DetailsSalon(
                                  salonName: appGet.centerFilter['data'][index]
                                      ['name'],
                                  salonAddress: appGet.centerFilter['data']
                                      [index]['address']??"",
                                  rate: appGet.centerFilter['data'][index]
                                      ['rate'].toDouble(),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
