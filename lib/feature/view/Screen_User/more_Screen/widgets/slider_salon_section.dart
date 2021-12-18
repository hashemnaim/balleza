import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';


class SliderSalonSection extends StatefulWidget {
 final List imageList ;
  SliderSalonSection({this.imageList});
  @override
  _SliderSalonSectionState createState() => _SliderSalonSectionState();
}

class _SliderSalonSectionState extends State<SliderSalonSection> {
  int _current = 1;

  //todo:change this list to your model
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: 213.h,
            child: PageView.builder(
              itemCount: widget.imageList.length,
              controller: PageController(
                initialPage: 1,
                viewportFraction: 0.77,
              ),
              onPageChanged: (int index) {
                print(index);
                _current = index;
                setState(() {});
              },
              itemBuilder: (_, i) {
                return Transform.scale(
                  scale: i == _current ? 1 : 0.8,
                  child:  ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: Image.asset(
                        widget.imageList[i],
                        fit: BoxFit.fill,
                        height: 213.h,
                        width: 319.w,
                      )),
                );
              },
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildDots(_current, widget.imageList.length),
          ),
        ),

      ],
    );
  }

  Widget _activePhoto(bool active) {
    return Container(
      width: 9.w,
      height: 9.h,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ?AppColors. primaryColor :AppColors. kPink2,
      ),
    );
  }

  List<Widget> _buildDots(int index, int count) {
    List<Widget> dots = [];
    for (int i = 0; i < count; ++i) {
      dots.add(_activePhoto(i == index));
    }
    return dots;
  }
}
