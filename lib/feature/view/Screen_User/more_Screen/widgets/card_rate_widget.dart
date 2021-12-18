
import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/values/constant.dart';
import 'package:belleza/feature/values/shadow.dart';
import 'package:belleza/feature/view/widgets/custom_image_Network.dart';
import 'package:belleza/feature/view/widgets/custom_rate.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardRateWidget extends StatefulWidget {
  final String name;
  final String address;
  final String image;
  final num rate;
  final String dat;
  final bool delet;
  final Color color;
  final int id;
  final int index;

  CardRateWidget(this.name, this.address, this.image, this.rate,
      {this.dat = "",
      this.delet = false,
      this.id = 0,
      this.index = 0,
      this.color = Colors.white});

  @override
  _CardRateWidgetState createState() => _CardRateWidgetState();
}

class _CardRateWidgetState extends State<CardRateWidget> {
  AppGetUser controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: sShadow1),
        height: setH(100, context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomerImageNetwork(
                  widget.image,
                  60,
                  60,
                  40,
                  borderColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: widget.name),
                    CustomText(
                      text: widget.address,
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    // widget.dat != ""
                    //     ? CustomText(
                    //         text: widget.dat,
                    //         color: Colors.grey,
                    //         fontSize: 14,
                    //       )
                    //     : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            right: 38, bottom: setH(20, context)),
                        child: CustomRate(rate: widget.rate.toDouble())),
                    widget.delet
                        ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: setH(100, context),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                      text:
                                                          "هل تريد حدف من المفضلة؟"),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () async {
                                                            // Get.back();
                                                            print(widget.id);
                                                       ServerUser.serverUser.     getDeleteMyFavorites(
                                                                widget.id);
                                                            Get.back();

                                                            // await getMyBookingsApproved(
                                                            //     controller
                                                            //         .positionLatitude
                                                            //         .value,
                                                            //     controller
                                                            //         .positionLongitude
                                                            //         .value,
                                                            //     init.DateFormat(
                                                            //             'y-MM-dd')
                                                            //         .format(
                                                            //             new DateTime
                                                            //                 .now()));

                                                            //  setState(() {});
                                                          },
                                                          child: Container(
                                                              child: CustomText(
                                                                  text:
                                                                      "نعم"))),
                                                      SizedBox(
                                                        width:
                                                            setW(20, context),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                              child: CustomText(
                                                                  text: "لا"))),
                                                      SizedBox(
                                                        width:
                                                            setW(10, context),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              );
                            },
                            child: CustomText(
                              text: "حدف من المفضلة",
                              color: Colors.red,
                            ))
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
