import 'package:flutter/material.dart';
import 'package:major_project/constant/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/form_entity.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({Key? key, required this.formEntity}) : super(key: key);
  final FormEntity formEntity;

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

    num data = widget.formEntity.projects +
        widget.formEntity.communicationSkill +
        widget.formEntity.leadership +
        widget.formEntity.creativity +
        widget.formEntity.achievements +
        widget.formEntity.jobKnowledge +
        widget.formEntity.problemSolvingAbility +
        widget.formEntity.productivity;

    var average = data / 8;

    final List<ChartData> chartData = [
      ChartData('Need Progress', 5 - average, Colors.red),
      ChartData('Your Average', average, Colors.blue),
    ];
    return SfCircularChart(
        title: ChartTitle(
            text: 'Average Graph',
            borderWidth: 2,
            // Aligns the chart title to left
            alignment: ChartAlignment.center,
            textStyle: TextStyle(
              color: kPrimaryTextColour,
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
