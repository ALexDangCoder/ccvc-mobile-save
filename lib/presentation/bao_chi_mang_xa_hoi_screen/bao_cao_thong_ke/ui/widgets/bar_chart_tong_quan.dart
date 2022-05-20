import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_caoThong_ke_bcmxh_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartTongQuanWidget extends StatelessWidget {
  final BaoCaoThongKeBCMXHCubit cubit;

  const BarChartTongQuanWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BarChartModel> listData=[];
    listData.add(BarChartModel(soLuong: 10, ten: 'muoi'));
    listData.add(BarChartModel(soLuong: 12, ten: 'hai'));
    listData.add(BarChartModel(soLuong: 3, ten: 'ba'));
    listData.add(BarChartModel(soLuong: 9, ten: 'bon'));
    return SfCartesianChart(
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
        interval: 5,
        minimum: 0,
        majorGridLines: const MajorGridLines(
          width: 0.34,
          color: colorA2AEBD,
          dashArray: [5, 5],
        ),
      ),
      series: <ChartSeries<BarChartModel, String>>[
        BarSeries<BarChartModel, String>(
          color: color20C997,
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
    );

  }
}
