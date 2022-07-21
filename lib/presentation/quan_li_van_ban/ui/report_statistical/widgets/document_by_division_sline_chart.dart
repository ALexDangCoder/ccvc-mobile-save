import 'dart:math';

import 'package:ccvc_mobile/bao_cao_module/widget/views/no_data_widget.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DocumentByDivisionSLineChart extends StatelessWidget {
  final List<ChartData> chartData;

  const DocumentByDivisionSLineChart({Key? key, required this.chartData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _LineChart(
      title: 'Thống kê văn bản đến',
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
          const _SLineChartView()
      ],
    );
  }
}

class _SLineChartView extends StatefulWidget {
  const _SLineChartView({Key? key}) : super(key: key);

  @override
  State<_SLineChartView> createState() => _SLineChartViewState();
}

class _SLineChartViewState extends State<_SLineChartView> {
  List<String>? _splineList;
  late String _selectedSplineType;
  SplineType? _spline;
  List<_ChartData> listChart = [];
  List<_ChartData> listChart2 = [];

  @override
  void initState() {
    final rd = Random();
    _selectedSplineType = 'natural';
    _spline = SplineType.natural;
    _splineList =
        <String>['natural', 'monotonic', 'cardinal', 'clamped'].toList();
    listChart = List.generate(
      12,
      (index) => _ChartData(
        (index + 1).toDouble(),
        rd.nextInt(4000).toDouble(),
      ),
    ).toList();
    listChart2 = List.generate(
      12,
      (index) => _ChartData(
        (index + 1).toDouble(),
        rd.nextInt(4000).toDouble(),
      ),
    ).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTypesSplineChart();
  }

  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter stateSetter) {
        return Row(
          children: <Widget>[
            const Text(
              'Spline type ',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              height: 50,
              alignment: Alignment.bottomLeft,
              child: DropdownButton<String>(
                  focusColor: Colors.transparent,
                  underline:
                      Container(color: const Color(0xFFBDBDBD), height: 1),
                  value: _selectedSplineType,
                  items: _splineList!.map((String value) {
                    return DropdownMenuItem<String>(
                      value: (value != null) ? value : 'natural',
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    _onPositionTypeChange(value.toString());
                    stateSetter(() {});
                  }),
            ),
          ],
        );
      },
    );
  }

  /// Returns the spline types chart.
  SfCartesianChart _buildTypesSplineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
        position: LegendPosition.top,
      ),
      primaryXAxis: NumericAxis(
        labelPosition: ChartDataLabelPosition.outside,
        visibleMaximum: 6.0,
        interval: 1,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: '',
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: _getSplineTypesSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render on the spline chart.
  List<SplineSeries<_ChartData, num>> _getSplineTypesSeries() {
    return <SplineSeries<_ChartData, num>>[
      SplineSeries<_ChartData, num>(
        name: 'HELo',
        color: colorFF9F43,
        splineType: _spline,
        dataSource: listChart,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        markerSettings:
            const MarkerSettings(isVisible: true, color: colorFF9F43),
      ),
      SplineSeries<_ChartData, num>(
        splineType: _spline,
        dataSource: listChart2,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        color: color5A8DEE,
        markerSettings:
            const MarkerSettings(isVisible: true, color: color5A8DEE),
      )
    ];
  }

  /// Method to change the spline type using dropdown menu.
  void _onPositionTypeChange(String item) {
    _selectedSplineType = item;
    if (_selectedSplineType == 'natural') {
      _spline = SplineType.natural;
    }
    if (_selectedSplineType == 'monotonic') {
      _spline = SplineType.monotonic;
    }
    if (_selectedSplineType == 'cardinal') {
      _spline = SplineType.cardinal;
    }
    if (_selectedSplineType == 'clamped') {
      _spline = SplineType.clamped;
    }
    setState(() {
      /// update the spline type changes
    });
  }

  @override
  void dispose() {
    _splineList!.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final double x;
  final double y;
}
