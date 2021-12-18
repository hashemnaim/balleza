import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final IconData icon;
  final TextInputType textInputType;
  final bool password;
  final bool isLocation;
  final String textInitialValue;
  final TextEditingController textEditingController;
  CustomTextFormField(
      {Key key,
      this.hintText,
      this.password = false,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.icon,
      this.isLocation = false,
      this.textInputType = TextInputType.text,
      this.textEditingController,
      this.textInitialValue});
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  IconData iconData = FontAwesomeIcons.eyeSlash;
  bool toggleEye = true;

  fmToggleEye() {
    toggleEye = !toggleEye;
    iconData = toggleEye ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 55,
      child: TextFormField(
        initialValue: widget.textInitialValue,
        controller: widget.textEditingController,
        validator: (value) => widget.validator(value),
        onSaved: (newvalue) => widget.onSaved(newvalue),
        onChanged: (value) => widget.onSaved(value),
        obscureText: widget.password ? toggleEye : false,
        cursorColor: Colors.grey,
        keyboardType: widget.textInputType,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          prefixIcon: Icon(
            widget.icon,
            size: 24.0,
          ),

          labelText: translator.translate(widget.hintText),
          labelStyle: GoogleFonts.cairo(
            color: Colors.grey,
            fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
          ),

          suffixIcon: widget.isLocation
              ? Padding(
                  padding: EdgeInsets.all(2.0),
                  child: GestureDetector(
                    // onTap: () => kNavigatorPush(context, SelectAddress()),
                    child: SvgPicture.asset(
                      'assets/svg/location.svg',
                      fit: BoxFit.contain,
                      height: 10,
                      width: 10,
                    ),
                  ),
                )
              : widget.password
                  ? GestureDetector(
                      child: Icon(
                        iconData,
                        color: Color(0xffEDF1F7),
                      ),
                      onTap: () {
                        fmToggleEye();
                      },
                    )
                  : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.grayText, fontSize: 14.sp),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grayText, width: 2.0.w),
            borderRadius: BorderRadius.all(new Radius.circular(10.0)),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: AppColors.grayText, width: 2.0.w),
          //   borderRadius: BorderRadius.all(new Radius.circular(10.0)
          // )),
          // enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(
          //   color: AppColors.primaryColor,
          //   width: 0.5.w,
          // )),
        ),
      ),
    );
  }
}
