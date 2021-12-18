import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/values/string.dart';
import 'package:belleza/feature/view/Screen_User/home_Screen/widgets/slider_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSlider extends StatefulWidget {
  final List list;

  const CustomSlider(this.list);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CustomSlider> {
  AppGetUser appGet = Get.find();
  int _current = 0;

  List<Widget> buildSlider() {
    List list = appGet.slider['data'];

    final List<Widget> imageSliders = appGet.slider.isNotEmpty
        ? list
            .map(
              (item) => PageView.builder(
                itemCount: list.length,
                controller: PageController(
                  // initialPage: 1,
                  viewportFraction: 0.9,
                ),
                onPageChanged: (int index) {
                  print(index);
                  _current = index;
                  setState(() {});
                },
                itemBuilder: (_, i) {
                  return Transform.scale(
                    scale: i == _current ? 1 : 0.9,
                    child: SliderItem(
                      image: item["logo"],
                      rate: item['rate'].toDouble(),
                      salonAddress: item['address'] ?? "",
                      salonName: item['name'],
                    ),
                  );
                },
              ),
            )
            .toList()
        : Container(width: 450, height: 230, child: Image.asset(loading));

    return imageSliders;
  }

  List<Widget> buildIndicator() {
    List list = appGet.slider['data'];
    final List<Widget> indicators = list.isNotEmpty
        ? list.map((url) {
            int index = list.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? AppColors.primaryColor
                    : Color(0xffC3F3EF),
              ),
            );
          }).toList()
        : Container();
    return indicators;
  }

  CarouselController carouselController;
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Obx(() {
      return appGet.slider.isNotEmpty
          ? Stack(children: [
              CarouselSlider(
                carouselController: carouselController,
                items: buildSlider(),
                options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    height: setH(245, context),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Positioned(
                bottom: 0,
                left: setW(165, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buildIndicator(),
                ),
              ),
            ])
          : Center(
              child: Container(
                  width: 450, height: 230, child: Image.asset(loading)));
    });
  }
}
