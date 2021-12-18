import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  final String titel;
  final Function onChanged;
  final String init;
  final bool enabled;

  final int va;
  CustomTextFiled(
      {this.titel = "",
      this.onChanged,
      this.va = 0,
      this.init = "",
      this.enabled = false});
  @override
  _TextFiledCustomerState createState() => _TextFiledCustomerState();
}

class _TextFiledCustomerState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextFormField(
            enabled: widget.enabled,
            keyboardType: TextInputType.values[widget.va],
            onChanged: (newValue) => widget.onChanged(newValue),
            initialValue: widget.init,
            style: TextStyle(color: Colors.grey),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                hintText: widget.titel,
                hintStyle: TextStyle(
                    color: Color(0xffAFADA4),
                    fontSize: 12,
                    fontFamily: "Cairo"),
                border: InputBorder.none)),
        decoration: widget.enabled
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 1),
                  ),
                ],
                color: Colors.white,
              )
            : null);
  }
}
