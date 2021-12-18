import 'package:belleza/feature/values/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomRadio extends StatefulWidget {
  final String titel;
  final String titel2;
  final String titel3;
  int i = 0;
  CustomRadio({
    this.titel,
    this.titel2,
    this.titel3,
    this.i = 3,
  });
  @override
  _CustomerRadioState createState() => _CustomerRadioState();
}

enum SingingCharacter { chash, online, program }

class _CustomerRadioState extends State<CustomRadio> {
  SingingCharacter _character = SingingCharacter.chash;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RadioListTile<SingingCharacter>(
          dense: true,
          value: SingingCharacter.chash,
          groupValue: _character,
          activeColor: AppColors.primaryColor,
          title: CustomText(
            text: widget.titel,
            fontSize: 18,
          ),
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              print(_character);
            });
          },
        ),
    widget.i != 2
            ? Container()
            :     RadioListTile<SingingCharacter>(
          dense: true,
          value: SingingCharacter.online,
          groupValue: _character,
          activeColor: AppColors.primaryColor,
          title: CustomText(
            text: widget.titel2,
            fontSize: 18,
          ),
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
              print(_character);
            });
          },
        ),
        widget.i != 3
            ? Container()
            : RadioListTile<SingingCharacter>(
                dense: true,
                value: SingingCharacter.program,
                groupValue: _character,
                activeColor: AppColors.primaryColor,
                title: CustomText(
                  text: widget.titel3,
                  fontSize: 18,
                ),
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    print(_character);
                  });
                },
              ),
      ],
    );
  }
}
