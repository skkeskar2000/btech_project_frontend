import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({Key? key, required this.scoreData}) : super(key: key);
  final Map<String,dynamic>scoreData;
  @override
  Widget build(BuildContext context) {
    late List<_ChartData> data;
    late TooltipBehavior _tooltip;
    data = scoreData.entries.map((entry) {
      var w = _ChartData(entry.key.toString(), double.parse(entry.value));
      return w;
    }).toList();
    _tooltip = TooltipBehavior(enable: true);

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
            )),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 10, interval: 0.1),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Gold',
              color: const Color.fromRGBO(8, 142, 255, 1))
        ],
      ),
    );
  }
}


class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
