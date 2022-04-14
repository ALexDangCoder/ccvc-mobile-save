import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final List<LineChartData> listData;

  const LineChartWidget({
    Key? key,
    required this.listData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<YKNDByMonth> listTest1=[
      YKNDByMonth(month: 1,quantities: 10),
      YKNDByMonth(month: 2,quantities: 20),
      YKNDByMonth(month: 3,quantities: 30),
      YKNDByMonth(month: 4,quantities: 40),
      YKNDByMonth(month: 5,quantities: 50),
    ];
    final List<YKNDByMonth> listTest2=[
    YKNDByMonth(month: 1,quantities: 100),
    YKNDByMonth(month: 2,quantities: 80),
    YKNDByMonth(month: 3,quantities: 120),
    YKNDByMonth(month: 4,quantities: 160),
    YKNDByMonth(month: 5,quantities: 180),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child:  SfCartesianChart(
        margin: const EdgeInsets.only(top: 20),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(
            alignment: ChartAlignment.near,
            text: S.current.thang,
            textStyle: textNormalCustom(
              color: AqiColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          placeLabelsNearAxisLine: true,
          labelStyle: textNormalCustom(
            color: AqiColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          axisLine: const AxisLine(
            color: AqiColor,
            width: 0.41,
          ),
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
          interval: 10,
          minimum: 0,
          majorGridLines: const MajorGridLines(
            width: 0.41,
            dashArray: [5, 5],
          ),
        ),
        series: <ChartSeries<LineChartData, String>>[
          StackedLineSeries<LineChartData, String>(
            color: choXuLyColor,
            dataSource: listData,
            xValueMapper: (LineChartData sales, _) => sales.date,
            yValueMapper: (LineChartData sales, _) =>
            sales.count,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: textNormalCustom(
                color: infoColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              labelAlignment: ChartDataLabelAlignment.outer,
            ),
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: choXuLyColor,
            ),
          ),
        ],
      ),
    );
  }
}
class LineChartData{
  final String date;
  final int count;

  LineChartData({required this.date,required this.count});
}
