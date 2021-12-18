import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarItem {
  IconData icon;
  String titel;
  bool hasNotification;

  CustomAppBarItem({this.icon, this.hasNotification = false, this.titel});
}

class CustomBottomAppBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List<CustomAppBarItem> items;

  CustomBottomAppBar({this.onTabSelected, this.items});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int selectedIndex = 0;
  AppGetUser appGet = Get.find();

  void _updateIndex(index) {
    widget.onTabSelected(index);
    setState(() {
      selectedIndex = index;
      appGet.setindexNav(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabIcon(
          index: index, item: widget.items[index], onPressed: _updateIndex);
    });

    return BottomAppBar(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[300]),
        ),
        height: 50.0,
        child: Row(
          //  mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
      shape: CircularNotchedRectangle(),
    );
  }

  Widget _buildTabIcon(
      {int index, CustomAppBarItem item, ValueChanged<int> onPressed}) {
    return Expanded(
      child: SizedBox(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
              onTap: () => onPressed(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      maxRadius: 12,
                      minRadius: 12,
                      backgroundColor: Colors.transparent,
                      //  contoller.indexNav==index?Colors.white:Colors.transparent,
                      child: Icon(item.icon,
                          color: appGet.indexNav == index
                              ? AppColors.primaryColor
                              : Colors.black)),
                  CustomText(
                      text: item.titel,
                      fontSize: 10,
                      color: appGet.indexNav == index
                          ? AppColors.primaryColor
                          : Colors.black),
                ],
              )),
        
        ),
      ),
    );
  }
}
