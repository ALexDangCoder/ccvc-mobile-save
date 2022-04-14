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
    );
    // return StreamBuilder<List<BarChartModel>>(
    //   stream: cubit.chartTongQuan,
    //   builder: (context, snapshot) {
    //     final data = snapshot.data ?? [];
    //     return cubit.checkDataList(data)
    //         ? SfCartesianChart(
    //             tooltipBehavior: TooltipBehavior(
    //               enable: true,
    //               textStyle: textNormalCustom(
    //                 color: infoColor,
    //                 fontWeight: FontWeight.w400,
    //                 fontSize: 10,
    //               ),
    //             ),
    //             primaryXAxis: CategoryAxis(
    //               placeLabelsNearAxisLine: true,
    //               labelStyle: textNormalCustom(
    //                 color: AqiColor,
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //               maximumLabelWidth: 60,
    //               majorGridLines: const MajorGridLines(width: 0),
    //             ),
    //             primaryYAxis: CategoryAxis(
    //               labelStyle: textNormalCustom(
    //                 color: AqiColor,
    //                 fontSize: 12,
    //                 fontWeight: FontWeight.w400,
    //               ),
    //               placeLabelsNearAxisLine: true,
    //               axisLine: const AxisLine(
    //                 color: AqiColor,
    //                 width: 0.41,
    //               ),
    //               interval: 5,
    //               minimum: 0,
    //               majorGridLines: const MajorGridLines(
    //                 width: 0.34,
    //                 color: AqiColor,
    //                 dashArray: [5, 5],
    //               ),
    //             ),
    //             series: <ChartSeries<BarChartModel, String>>[
    //               BarSeries<BarChartModel, String>(
    //                 color: choXuLyYKND,
    //                 dataLabelSettings: DataLabelSettings(
    //                   isVisible: true,
    //                   textStyle: textNormalCustom(
    //                     color: infoColor,
    //                     fontWeight: FontWeight.w400,
    //                     fontSize: 11,
    //                   ),
    //                   labelAlignment: ChartDataLabelAlignment.outer,
    //                   labelPosition: ChartDataLabelPosition.outside,
    //                 ),
    //                 dataSource: data,
    //                 xValueMapper: (BarChartModel data, _) => data.ten,
    //                 yValueMapper: (BarChartModel data, _) => data.soLuong,
    //               ),
    //             ],
    //           )
    //         : Container(
    //             margin: const EdgeInsets.all(30),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   S.current.khong_co_du_lieu,
    //                 )
    //               ],
    //             ),
    //           );
    //   },
    // );
  }
}
