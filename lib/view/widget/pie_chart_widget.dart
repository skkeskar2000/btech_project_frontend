import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key, required this.formData,}) : super(key: key);
  final Map<String,dynamic> formData;
  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState(){
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late TooltipBehavior _tooltip;

    num data = 0;
    widget.formData.forEach((key, value) {
      data+= int.parse(value);
    });
    var average = data / widget.formData.length;
    print(data);
    print(average);
    final List<ChartData> chartData = [
      ChartData('Need Progress', (10 - average)*10, Colors.red),
      ChartData('Your Average', average*10, Colors.blue),
    ];
    return SfCircularChart(
        title: ChartTitle(
            text: 'Average Graph',
            borderWidth: 2,
            // Aligns the chart title to left
            alignment: ChartAlignment.center,
            textStyle: TextStyle(
              color: headingTextColor,
              fontFamily: 'Roboto',
              fontSize: 14,
            )
        ),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
      // Render pie chart
      PieSeries<ChartData, String>(
        dataSource: chartData,
        enableTooltip: true,
        pointColorMapper: (ChartData data, _) => data.color,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        dataLabelSettings: const DataLabelSettings(
            // Renders the data label
            isVisible: true),
      ),
    ]);
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
