import 'package:major_project_fronted/constant/custom_toast.dart';
import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class DailyCheckins extends StatefulWidget {
  final String id;
  final String name;

  const DailyCheckins({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<DailyCheckins> createState() => _DailyCheckinsState();
}

class _DailyCheckinsState extends State<DailyCheckins> {
  var myFormat = DateFormat('d-MM-yyyy');

  @override
  void initState() {
    // TODO: implement initState
    DateTime date = DateTime.now();
    Map<String, dynamic> attendance = {
      "empId": widget.id,
      "empName": widget.name,
      "date": myFormat.format(date)
    };
    Provider.of<FormController>(context, listen: false)
        .chekIfTodayMarked(data: attendance);

    Provider.of<FormController>(context, listen: false)
        .getdailyChekinEmployee(userId: widget.id);

    super.initState();
  }
  Widget monthCellBuildesr(BuildContext context, MonthCellDetails details) {
    if (details.appointments.isNotEmpty) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 6.5, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: Color(0xFFCB223F),
        ),
        child: Center(
          child: Text(
            details.date.day.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: Colors.white,
      ),
      child: Center(child: Text(details.date.day.toString())),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('in dailty');
    print(widget.name);

    return Consumer<FormController>(
      builder: (context, provider, child) {
        DataSource _getCalendarDataSource() {
          final List<Appointment> appointments = <Appointment>[];
          for (var date in provider.chekinDateList) {
            appointments.add(Appointment(
              startTime: date,
              endTime: date,
              isAllDay: true,
              subject: 'Done checkin',
              color: Colors.purple,
            ));
          }
          return DataSource(appointments);
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff373B61),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daily Check-Ins",
                              style: kTopTitleTextStyle,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Mark your presensense through online daily chek-Ins system.\nYou will be able to view your monthly attendance in dashboard.\nYour managers will also be able to track your attendance.',
                              style: kWhiteContentStyle,
                              softWrap: true,
                              maxLines: 7,
                            ),
                            provider.showButton
                                ? InkWell(
                                    onTap: () {
                                      DateTime date = DateTime.now();
                                      Map<String, dynamic> attendance = {
                                        "empId": widget.id,
                                        "empName": widget.name,
                                        "date": myFormat.format(date)
                                      };
                                      provider.markTodayChekin(
                                          attendance: attendance);
                                    },
                                    child: IconTextButton(
                                      icon: Icon(
                                        Icons.today,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      title: '  Chek-In Today ',
                                      isSelected: false,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      showCustomToast(
                                          'Already Checked-In today');
                                    },
                                    child: IconTextButton(
                                      icon: Icon(
                                        Icons.check_box,
                                        size: 0,
                                        color: Colors.white,
                                      ),
                                      title: 'Already Checked-In today',
                                      isSelected: false,
                                    ),
                                  )
                          ],
                        ),
                        Image(
                          height: 300,
                          width: 350,
                          image: AssetImage("assets/images/time.png"),
                          fit: BoxFit.cover,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
               Row(
                 children: [
                   Text('Your Monthly Attendance',style: kHeadingTextStyle,textAlign: TextAlign.start,),
                 ],
               ),
                Card(
                  elevation: 5,
                  child: SfCalendar(
                    allowViewNavigation: false,
                    view: CalendarView.month,
                    headerStyle: const CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: kContentStyle,
                    ),
                    dataSource: _getCalendarDataSource(),
                    monthCellBuilder: monthCellBuildesr,
                    monthViewSettings: const MonthViewSettings(
                      numberOfWeeksInView: 6,
                      appointmentDisplayCount: 1,
                      showTrailingAndLeadingDates: false,
                      showAgenda: false,
                      appointmentDisplayMode:
                      MonthAppointmentDisplayMode.none,
                      monthCellStyle: MonthCellStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}