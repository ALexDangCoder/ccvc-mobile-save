import 'dart:math';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DocumentByDivisionLineChart extends StatelessWidget {
  final String title;
  final List<ChartData> chartData;

  const DocumentByDivisionLineChart({Key? key, required this.chartData, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _LineChart(
      title: title,
      tittleStyle: textNormalCustom(
        color: textTitle,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      chartData: List.generate(
        chartData.length,
        (index) => ChartData(
          chartData[index].title,
          chartData[index].value,
          chartData[index].color,
        ),
      ),
    );
  }
}

class _LineChart extends StatelessWidget {
  final List<ChartData> chartData;
  final String title;
  final double paddingTop;
  final TextStyle? tittleStyle;
  final bool useVerticalLegend;

  const _LineChart({
    Key? key,
    required this.chartData,
    this.title = '',
    this.paddingTop = 20,
    this.tittleStyle,
    this.useVerticalLegend = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title.isEmpty)
          const SizedBox()
        else
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: paddingTop),
              child: FittedBox(
                child: Text(
                  title,
                  style: tittleStyle ??
                      textNormalCustom(
                        color: infoColor,
                        fontSize: 16,
                      ),
                ),
              ),
            ),
          ),
        if (chartData.indexWhere((element) => element.value != 0) == -1)
          const NodataWidget()
        else
          const _LineChartView()
      ],
    );
  }
}

class _LineChartView extends StatefulWidget {
  const _LineChartView({Key? key}) : super(key: key);

  @override
  State<_LineChartView> createState() => _LineChartViewState();
}

class _LineChartViewState extends State<_LineChartView> {
  List<_ChartData> chartData = [];

  @override
  void initState() {
    final rng = Random();
    chartData = List.generate(
      12,
      (index) => _ChartData(
        index + 1,
        rng.nextInt(5000).toDouble(),
        rng.nextInt(5000).toDouble(),
      ),
    ).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultLineChart();
  }

  /// Get the cartesian chart with default line series
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      onLegendTapped: (_){},
      plotAreaBorderWidth: 0,
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.top,
      ),
      primaryXAxis: NumericAxis(
        labelPosition: ChartDataLabelPosition.outside,
        visibleMaximum: 12,
        interval: 1,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: '',
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// The method returns line series to chart.
  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
        color: color5A8DEE,
        animationDuration: 2500,
        dataSource: chartData,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: S.current.nam_nay,
        markerSettings: const MarkerSettings(
          isVisible: true,
          color: color5A8DEE,
        ),
      ),
      LineSeries<_ChartData, num>(
        color: colorFF9F43,
        animationDuration: 2500,
        dataSource: chartData,
        width: 2,
        name: S.current.nam_truoc,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y2,
        markerSettings:
            const MarkerSettings(isVisible: true, color: colorFF9F43),
      )
    ];
  }

  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);

  final double x;
  final double y;
  final double y2;
}
