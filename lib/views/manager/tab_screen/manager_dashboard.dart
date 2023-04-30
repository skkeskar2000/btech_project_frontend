import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/model/charDataModel.dart';
import 'package:major_project_fronted/views/global%20widgits/custom_warning_card.dart';
import 'package:major_project_fronted/views/manager/widgets/assessment_log.dart';
import 'package:major_project_fronted/views/manager/widgets/chekin_with_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({Key? key}) : super(key: key);

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  var myFormat = DateFormat('d-MM-yyyy');

  @override
  void initState() {
    // TODO: implement initState
    apiCall();
    super.initState();
  }

  apiCall() async {
    DateTime date = DateTime.now();
    DateTime previousDate = date.subtract(Duration(days: 1));

    await Provider.of<FormController>(context, listen: false)
        .getAllTodayChekins(
            Date: myFormat.format(previousDate), isPrevious: true);
    print(myFormat.format(date));

    await Provider.of<FormController>(context, listen: false)
        .getAllTodayChekins(Date: myFormat.format(date), isPrevious: false);

    Provider.of<FormController>(context, listen: false).getCustomFormResponse();
    Provider.of<FormController>(context, listen: false).getAllChekin();

    totalEmployee = await Provider.of<AuthController>(context, listen: false)
        .allEmployeeList
        .length;
  }

  double yesterdayPercentage = 0;
  double todayPercentage = 0;

  void calculateAttendancePercentage(
      {required int yesterdaychekin,
      required int todaychekin,
      required int totalemp}) {
    yesterdayPercentage = (yesterdaychekin / totalemp) * 100;
    print(yesterdayPercentage);
    todayPercentage = (todaychekin / totalemp) * 100;
    print(todayPercentage);
  }

  int totalEmployee = 0;
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
    return Consumer<FormController>(
      builder: (context, provider, child) {
        DataSource _getCalendarDataSource() {
          final List<Appointment> appointments = <Appointment>[];
          for (var oneChekin in provider.listAllChekin) {
            appointments.add(Appointment(
              startTime: myFormat.parse(oneChekin.date),
              endTime:  myFormat.parse(oneChekin.date),
              isAllDay: true,
              subject: '${oneChekin.empName}',
              color: Colors.purple,
            ));
          }
          return DataSource(appointments);
        }
        calculateAttendancePercentage(
            yesterdaychekin: provider.allyesterdayChekinList.length,
            todaychekin: provider.allTodatyChekinList.length,
            totalemp: totalEmployee);
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: ChekinWithName()),
                    Expanded(child: AssessmentLog())
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text('Where to focus',style: kHeadingTextStyle,textAlign: TextAlign.start,),
                ),
                Row(
                  children: [
                    Expanded(
                        child: todayPercentage < yesterdayPercentage
                            ? CustomWarningMessageCard(
                                title: 'Fall in Chek-Ins',
                                warningMessage:
                                    'It is found that there is fall in daily chek-ins of your employees. The employee strength yesterday was ${yesterdayPercentage.toStringAsFixed(2)} % and it is fallen to $todayPercentage % today.',
                                icon: Icons.warning_rounded,
                                bgColor: Colors.redAccent,
                              )
                            : CustomWarningMessageCard(
                                title: 'Up-to the mark Chek-Ins',
                                warningMessage:
                                    'Congratulations today\'s chek-ins are significant. Today\'s chek-in percentage is ${todayPercentage.toStringAsFixed(2)}.',
                                icon: Icons.calendar_month,
                                bgColor: Colors.green,
                              )),
                    Expanded(
                      child: provider.lessPercentageCandidates != 0
                          ? CustomWarningMessageCard(
                              title: 'Poor Assessment performance',
                              warningMessage:
                                  'From assessment analysis total ${provider.lessPercentageCandidates} responses are having less than 50% score.',
                              icon: Icons.report,
                              bgColor: Colors.redAccent,
                            )
                          : const CustomWarningMessageCard(
                              title: 'Great Assessment performance',
                              warningMessage:
                                  'Assessment responses received are good all candidates are having score greater than 50%.',
                              icon: Icons.report,
                              bgColor: Colors.green,
                            ),
                    ),
                  ],
                ),
                Card(
                  margin:
                  const EdgeInsets.only(left: 10, right: 10, top: 30),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.cyan),
                      borderRadius: BorderRadius.circular(15)),
                  child: SfCartesianChart(

                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    plotAreaBorderWidth: 0,
                    title: ChartTitle(
                        text: 'Average Quiz Score Trends ',
                        alignment: ChartAlignment.near,
                        textStyle: TextStyle(fontSize: 16)),
                    primaryXAxis: CategoryAxis(
                        borderWidth: 0,
                        labelPlacement: LabelPlacement.onTicks,
                        labelStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: "LeagueSpartan"),
                        // minorTickLines: MinorTickLines(color: Colors.transparent),
                        minorGridLines:
                        MinorGridLines(color: Colors.transparent),
                        majorTickLines:
                        MajorTickLines(color: Colors.transparent),
                        majorGridLines: const MajorGridLines(
                            color: Colors.transparent)),
                    primaryYAxis: NumericAxis(
                        maximum: 100.0,
                        labelStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: "LeagueSpartan"),
                        minorTickLines:
                        MinorTickLines(color: Colors.transparent),
                        minorGridLines:
                        MinorGridLines(color: Colors.transparent),
                        majorTickLines:
                        MajorTickLines(color: Colors.transparent),
                        majorGridLines: const MajorGridLines(
                            color: Colors.transparent)),

                    series: <ChartSeries>[
                      SplineSeries<ChartDataEntity, String>(
                          dataSource: provider.quizResponseAverageGraphList,
                          xValueMapper: (ChartDataEntity chart, _) =>
                          chart.x,
                          yValueMapper: (ChartDataEntity chart, _) =>
                          chart.y,
                          splineType: SplineType.natural,
                          dataLabelSettings: DataLabelSettings(
                              alignment: ChartAlignment.center),
                          color: Color(0xff20b9fc))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Active Days Past Trends ',style: kHeadingTextStyle,),
                ),
                Card(
                  elevation: 5,
                  child: SfCalendar(
                    allowViewNavigation: false,
                    showNavigationArrow: true,
                    view: CalendarView.month,
                    headerStyle: const CalendarHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: kContentStyle,
                    ),
                    dataSource: _getCalendarDataSource(),
                     monthCellBuilder: monthCellBuildesr,
                    monthViewSettings: const MonthViewSettings(
                      numberOfWeeksInView: 6,
                      appointmentDisplayCount: 10,
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