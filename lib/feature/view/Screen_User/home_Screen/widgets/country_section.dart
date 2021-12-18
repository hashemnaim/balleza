import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/view/widgets/isload.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:belleza/feature/values/style.dart';
import 'package:get/get.dart';

class CitiesSection extends StatefulWidget {
  @override
  _CitiesSectionState createState() => _CitiesSectionState();
}

class _CitiesSectionState extends State<CitiesSection> {
  int _current = -1;
  AppGetUser appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => appGet.cities.isEmpty
        ? Center(child: IsLoad())
        : Container(
            height: appGet.cities['data'].length > 0 ? 60.h : 0,
            child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.all(0),
                itemCount: appGet.cities['data'].length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  bool selected = _current == index;
                  return GestureDetector(
                    onTap: () {
                      _current = index;
                      print(index);
                      appGet.centerFilter.value = {};
                      ServerUser.serverUser.setCenterFilter(
                          appGet.categories['data'][index]['id'],
                          appGet.cities['data'][index]['id']);

                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: _current == index
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              boxShadow: sShadow2,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xffEFE0E4))),
                          width: 71.w,
                          height: 43.h,
                          child: Center(
                            child: Text(appGet.language.value == "en"
                                            ? appGet.cities['data'][index]['name_en']:
                              appGet.cities['data'][index]['name'],
                              style: kHomeStyle3.copyWith(
                                  color: selected
                                      ? Colors.white
                                      : AppColors.kBlack),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ));
  }
}
