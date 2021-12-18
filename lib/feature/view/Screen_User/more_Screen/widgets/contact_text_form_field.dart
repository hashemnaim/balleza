import 'package:belleza/feature/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField2 extends StatefulWidget {
   String hintText;
  final String initialValue;
  final Function validator;
  final Function onSaved;
  final Function onChange;
  final double minHeight;
  final TextInputType textInputType;

  CustomTextFormField2({
    Key key,
    this.hintText,
    this.validator,
    this.onChange,
    this.initialValue = "",
    this.onSaved,
    @required this.minHeight,
    this.textInputType = TextInputType.text,
  });

  @override
  _CustomTextFormField2State createState() => _CustomTextFormField2State();
}

class _CustomTextFormField2State extends State<CustomTextFormField2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      constraints: BoxConstraints(minHeight: widget.minHeight),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
          border: Border.all(color: AppColors.kPink2)),
      child: TextFormField(
        keyboardType: widget.textInputType,
        initialValue: widget.initialValue,
        validator: (value) => widget.validator(value),
        onSaved: (newValue) => widget.onSaved(newValue),
        onChanged: (value) => widget.onChange(value),
        style: TextStyle(
          fontSize: 16.sp,
          color: Color(0xFF313A44),
        ),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: (widget.hintText)),
      ),
    );
  }
}
