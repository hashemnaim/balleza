import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesDropDown extends StatefulWidget {
  final Function dropDownBtnFunction;
  final List list;
  final String name;
  final String hint;
  final int index;
  final IconData icon;

  CategoriesDropDown({
    this.dropDownBtnFunction,
    this.list,
    this.name = "",
    this.hint = "",
    this.index ,
    this.icon ,
  });
  @override
  _CategoriesDropDownState createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.grayText, width: 1.5.w),
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        child: DropdownButton(
            hint:
             Row(
                  children: [
                    Icon(widget.icon,color: Colors.grey,),
                    SizedBox(width: setW(10, context),),
                  widget.index!=null
                ?   CustomText(text: widget.list[widget.index]['${widget.name}'])  : CustomText(
                    text: widget.hint,
                    color: Colors.grey,
                  ),
                  ],
                ),
              
            isExpanded: true,
            icon: Icon(Icons.keyboard_arrow_down),
            underline: Container(),
            items: widget.list.map((e) {
              return DropdownMenuItem(
                child: CustomText(text: e['${widget.name}']),
                value: e['id'],
              );
            }).toList(),
            onChanged: (value) => widget.dropDownBtnFunction(value)));
  }
}
