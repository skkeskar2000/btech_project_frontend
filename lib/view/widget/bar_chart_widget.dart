
import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('JobKnowledge', 6),
      _ChartData('achievements', 4),
      _ChartData('creativity', 2),
      _ChartData('leadership', 3),
      _ChartData('communicationSkill', 5),
      _ChartData('projects', 4),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SfCartesianChart(
            title: ChartTitle(
                text: 'Bar Graph',
                borderWidth: 2,
                // Aligns the chart title to left
                alignment: ChartAlignment.center,
                textStyle: TextStyle(
                  color: headingTextColor,
                  fontFamily: 'Roboto',
                  fontSize: 14,
                )
            ),
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 5, interval: 0.5),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<_ChartData, String>>[
              ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  color: const Color.fromRGBO(8, 142, 255, 1))
            ]));

  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}