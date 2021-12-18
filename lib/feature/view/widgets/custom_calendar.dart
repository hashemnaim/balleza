import 'package:belleza/feature/server/app_get_user.dart';
import 'package:belleza/feature/server/server_user.dart';
import 'package:belleza/feature/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:belleza/feature/values/colors.dart';
import 'package:belleza/feature/values/style.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final int id;

  const Calendar({Key key, this.id}) : super(key: key);
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  AppGetUser appGetUser = Get.find();
  CalendarController _controller;
  DateTime startDate = DateTime.now().subtract(Duration(days: 2));
  DateTime endDate = DateTime.now().add(Duration(days: 2));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    ServerUser.serverUser.setHoursAvailableInDate(
        widget.id, DateTime.now().toIso8601String().substring(0, 9));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            initialCalendarFormat: CalendarFormat.twoWeeks,
            // locale: 'ar',
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: kBtnTextStyle2.copyWith(
                fontSize: 14.sp,
              ),
              weekendStyle: kBtnTextStyle2.copyWith(
                fontSize: 14.sp,
              ),
            ),
            calendarStyle: CalendarStyle(
                todayColor: Colors.orange,
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white)),
            headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: true,
                titleTextStyle:
                    GoogleFonts.cairo(color: Colors.white, fontSize: 20),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )),
            startingDayOfWeek: StartingDayOfWeek.saturday,
            onDaySelected: (date, events, a) {
              appGetUser.hoursAvailableInDate.clear();
              ServerUser.serverUser.setHoursAvailableInDate(
                  widget.id, date.toIso8601String().substring(1, 10));
              appGetUser.setData(date.toIso8601String().substring(1, 10));
            },
            builders: CalendarBuilders(
              weekendDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: date.day.toString(),
                    color: Colors.white,
                  )),
              selectedDayBuilder: (context, date, events) => CircleAvatar(
                radius: 1,
                backgroundColor: AppColors.kPink2,
                child: CustomText(
                    text: date.day.toString(), color: AppColors.primaryColor),
              ),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: CustomText(
                    text: date.day.toString(),
                    color: Colors.white,
                  )),
              dayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  child: CustomText(
                    text: date.day.toString(),
                    color: Colors.white,
                  )),
            ),
            calendarController: _controller,
          )
        ],
      ),
    );
  }
}
