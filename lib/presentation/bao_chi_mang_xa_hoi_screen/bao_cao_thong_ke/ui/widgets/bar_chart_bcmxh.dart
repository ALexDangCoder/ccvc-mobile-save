import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarCharWidget extends StatelessWidget {
  final List<BarChartModel> listData;
  const BarCharWidget({
    Key? key,
    required this.listData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  listData.isNotEmpty? SfCartesianChart(
      tooltipBehavior: TooltipBehavior(
        enable: true,
        textStyle: textNormalCustom(
          color: infoColor,
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      ),
      primaryXAxis: CategoryAxis(
        placeLabelsNearAxisLine: true,
        labelStyle: textNormalCustom(
          color: AqiColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        maximumLabelWidth: 60,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: CategoryAxis(
        labelStyle: textNormalCustom(
          color: AqiColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        placeLabelsNearAxisLine: true,
        axisLine: const AxisLine(
          color: AqiColor,
          width: 0.41,
        ),
        interval: 5,
        minimum: 0,
        majorGridLines: const MajorGridLines(
          width: 0.34,
          color: AqiColor,
          dashArray: [5, 5],
        ),
      ),
      series: <ChartSeries<BarChartModel, String>>[
        BarSeries<BarChartModel, String>(
          color: choXuLyYKND,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            textStyle: textNormalCustom(
              color: infoColor,
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


