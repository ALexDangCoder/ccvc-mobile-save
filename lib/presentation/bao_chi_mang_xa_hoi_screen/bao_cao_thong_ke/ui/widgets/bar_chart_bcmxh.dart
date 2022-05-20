import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarCharWidget extends StatelessWidget {
  final List<BarChartModel> listData;
  final Color? color;
  final bool? direction;
  const BarCharWidget({
    Key? key,
    this.color,
    this.direction,
    required this.listData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  listData.isNotEmpty? SfCartesianChart(
      isTransposed: direction??false,
      tooltipBehavior: TooltipBehavior(
        enable: true,
        textStyle: textNormalCustom(
          color: color667793,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      ),
      primaryXAxis: CategoryAxis(
        placeLabelsNearAxisLine: true,
        labelStyle: textNormalCustom(
          color: colorA2AEBD,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        maximumLabelWidth: 60,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: CategoryAxis(
        labelStyle: textNormalCustom(
          color: colorA2AEBD,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        placeLabelsNearAxisLine: true,
        axisLine: const AxisLine(
          color: colorA2AEBD,
          width: 0.41,
        ),
        interval: getMax(listData),
        minimum: 0,
        majorGridLines: const MajorGridLines(
          width: 0.34,
          color: colorA2AEBD,
          dashArray: [5, 5],
        ),
      ),
      series: <ChartSeries<BarChartModel, String>>[
        BarSeries<BarChartModel, String>(
          color: color ?? Colors.red,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: textNormalCustom(
              color: color667793,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
            labelAlignment: ChartDataLabelAlignment.outer,
            labelPosition: ChartDataLabelPosition.outside,
          ),
          dataSource: listData,
          xValueMapper: (BarChartModel data, _) => data.ten,
          yValueMapper: (BarChartModel data, _) => data.soLuong,
        ),
      ],
    ): const NodataWidget();
  }
}

double getMax(List<BarChartModel> data) {
  double value = 0;
  for (final element in data) {
    if ((element.soLuong.toDouble()) > value) {
      value = element.soLuong.toDouble();
    }
  }
  final double range = value % 10;
  return (value + (10.0 - range)) / 5;
}



