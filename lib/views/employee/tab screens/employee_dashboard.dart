import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/model/charDataModel.dart';
import 'package:major_project_fronted/views/global%20widgits/custom_flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EmployeeEvaluationDashboard extends StatefulWidget {
  final String id;
  final String name;
  final String text;

  const EmployeeEvaluationDashboard(
      {Key? key, required this.id, required this.name, required this.text})
      : super(key: key);

  @override
  State<EmployeeEvaluationDashboard> createState() =>
      _EmployeeEvaluationDashboardState();
}

class _EmployeeEvaluationDashboardState
    extends State<EmployeeEvaluationDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<FormController>(context, listen: false)
        .getCustomFormResponseByUserId(userID: widget.id);
    Provider.of<FormController>(context, listen: false)
        .getdailyChekinEmployee(userId: widget.id);
    Provider.of<FormController>(context, listen: false)
        .getCustomFormAttribute();

    super.initState();
  }

  int chekin = 0;
  double topScore = 0;
  int totalForms = 0;
  int submittedForms = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<FormController>(
      builder: (context, provider, child) {
        chekin = provider.chekinDateList.length;
        topScore = provider.maxVal - 2;
        totalForms = provider.customFormAttributeList.length;
        submittedForms = provider.userFormResp.length;
        return Material(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 350,
                  child: Stack(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        decoration: BoxDecoration(
                            color: Color(0xff373b61),
                            borderRadius: BorderRadius.circular(15)),
                        height: 250,
                        width: double.maxFinite,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    widget.text != 'Your'
                                        ? IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.arrow_back_ios_new_rounded,
                                              color: Colors.white,
                                            ))
                                        : Container(),
                                    Text(
                                      'Track ${widget.text} Progress',
                                      style: kHeadingTextStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'lorem ipsunm done ok quiz gigee lorem ipsunm done ok quiz gigee. \nlorem ipsunm done ok quiz gigee ',
                                  style: kWhiteContentStyle,
                                )
                              ],
                            ),
                            Image(
                              image: AssetImage('assets/images/progress.png'),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffa7d5e5),
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.only(
                                left: 100, right: 100, top: 190),
                            height: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomFlipCard(
                                  frontData: 'Today Task',
                                  backText:
                                      'Based on your responses,one top score is generated.',
                                  frontTitle: 'Daily Task',
                                  frontSubtitle: 'units',
                                  color: Color(0xfffd5c82),
                                ),
                                CustomFlipCard(
                                  frontData: '$chekin',
                                  backText:
                                      'Daily chek-Ins shows your attentiveness throughout the month.',
                                  frontTitle: 'Daily Chek-Ins',
                                  frontSubtitle: 'Days',
                                  color: Color(0xffcb80ff),
                                ),
                                CustomFlipCard(
                                  frontData: '$submittedForms',
                                  backText:
                                      'Number of responses you have given out of total assessments.',
                                  frontTitle: 'Assessments',
                                  frontSubtitle: 'Out of ${totalForms}.',
                                  color: Color(0xff241b35),
                                ),
                                CustomFlipCard(
                                  frontData: '$topScore',
                                  backText:
                                      'Based on your responses,one top score is generated.',
                                  frontTitle: 'Top Score',
                                  frontSubtitle: 'Marks',
                                  color: Color(0xfff8b018),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        'Assessment Analysis',
                        style: kHeadingTextStyle,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(15)),
                        child: SfCartesianChart(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 20),
                          plotAreaBorderWidth: 0,
                          title: ChartTitle(
                              text: 'Percentage Score ',
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
                                dataSource:
                                    provider.userTotalAnsPercentageGraph,
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
                    ),
                    Expanded(
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.cyan),
                            borderRadius: BorderRadius.circular(15)),
                        child: SfCartesianChart(
                          title: ChartTitle(
                              textStyle: const TextStyle(fontSize: 16),
                              text: 'Top Scores',
                              alignment: ChartAlignment.near),
                          margin: const EdgeInsets.all(20),
                          plotAreaBorderWidth: 0,
                          backgroundColor: Colors.white,
                          borderWidth: 0,
                          primaryXAxis: CategoryAxis(
                            majorTickLines:
                                const MajorTickLines(color: Colors.white),
                            axisLine: const AxisLine(color: Colors.white),
                            isVisible: true,
                            majorGridLines:
                                const MajorGridLines(color: Colors.transparent),
                          ),
                          primaryYAxis: NumericAxis(
                              majorTickLines: const MajorTickLines(
                                  color: Colors.grey, size: 0.5),
                              axisLine: const AxisLine(color: Colors.grey),
                              maximum: provider.maxVal,
                              interval: 3,
                              minimum: 0,
                              majorGridLines: const MajorGridLines(
                                color: Colors.transparent,
                              )),
                          // tooltipBehavior: _tooltip,
                          series: <ChartSeries>[
                            BarSeries<ChartDataEntity, String>(
                              sortingOrder: SortingOrder.none,
                              dataSource: provider.userTotalScoreGraph,
                              xValueMapper: (ChartDataEntity chart, _) =>
                                  chart.x,
                              yValueMapper: (ChartDataEntity chart, _) =>
                                  chart.y,
                              name: 'Heighest',
                              color: const Color.fromRGBO(8, 142, 255, 1),
                              width: 0.59,
                              gradient: LinearGradient(colors: [
                                Color(0xff20b9fc).withOpacity(0.5),
                                Color(0xff20b9fc)
                              ]),
                              borderRadius: BorderRadius.circular(20),
                              isVisible: true,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
