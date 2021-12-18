
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SalonCategoryList extends StatefulWidget {
  final List itemCategory;
  SalonCategoryList({this.itemCategory});
  @override
  _SalonCategoryListState createState() => _SalonCategoryListState();
}

class _SalonCategoryListState extends State<SalonCategoryList> {
  int _current = -1;
  final AppGetUser appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: widget.itemCategory.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            bool selected = _current == index;
            return GestureDetector(
              onTap: () {
                _current = index;

                      appGet.topRated.value = {};
                      ServerUser.serverUser.getShopMain(1);
                                

                setState(() {});
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: selected ? AppColors.primaryColor : Colors.white,
                        boxShadow: sShadow2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffEFE0E4))),
                    // width: 129.w,
                    // height: 43.h,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0,right: 10),
                        child: CustomText(
                            text: widget.itemCategory[index]['name'],
                            color: selected ? Colors.white : AppColors.kBlack),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
