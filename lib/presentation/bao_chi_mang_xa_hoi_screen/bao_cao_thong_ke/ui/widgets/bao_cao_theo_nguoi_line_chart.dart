import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/nguon_bao_cao_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_caoThong_ke_bcmxh_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartTheoNguonWidget extends StatelessWidget {
  final BaoCaoThongKeBCMXHCubit baoCaoThongKeBCMXHCubit;

  const LineChartTheoNguonWidget({
    Key? key,
    required this.baoCaoThongKeBCMXHCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NguonBaoCaoLineChartModel>(
      stream: baoCaoThongKeBCMXHCubit.lineChartTheoNguon,
      builder: (context, snapshot) {
        final data = snapshot.data ??
            NguonBaoCaoLineChartModel(
              baoChi: [],
              nguonKhac: [],
              mangXaHoi: [],
              forum: [],
              blog: [],
            );
        final List<List<LineChartData>> listData = [
          data.baoChi,
          data.nguonKhac,
          data.mangXaHoi,
          data.forum,
          data.blog,
        ];
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: SfCartesianChart(
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
              interval: getMaxList(listData),
              minimum: 0,
              majorGridLines: const MajorGridLines(
                width: 0.41,
                dashArray: [5, 5],
              ),
            ),
            series: <ChartSeries<LineChartData, String>>[
              LineSeries<LineChartData, String>(
                color: redChart,
                dataSource: data.baoChi,
                xValueMapper: (LineChartData sales, _) => sales.date,
                yValueMapper: (LineChartData sales, _) => sales.count,
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
                  color: redChart,
                ),
              ),
              LineSeries<LineChartData, String>(
                color: orangeDamChart,
                dataSource: data.mangXaHoi,
                xValueMapper: (LineChartData sales, _) => sales.date,
                yValueMapper: (LineChartData sales, _) => sales.count,
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
                  color: orangeDamChart,
                ),
              ),
              LineSeries<LineChartData, String>(
                color: purpleChart,
                dataSource: data.blog,
                xValueMapper: (LineChartData sales, _) => sales.date,
                yValueMapper: (LineChartData sales, _) => 15,
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
                  color: purpleChart,
                ),
              ),
              LineSeries<LineChartData, String>(
                color: orangeNhatChart,
                dataSource: data.forum,
                xValueMapper: (LineChartData sales, _) => sales.date,
                yValueMapper: (LineChartData sales, _) => sales.count,
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
                  color: orangeNhatChart,
                ),
              ),
              LineSeries<LineChartData, String>(
                color: orangeDamChart,
                dataSource: data.nguonKhac,
                xValueMapper: (LineChartData sales, _) => sales.date,
                yValueMapper: (LineChartData sales, _) => sales.count,
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
                  color: orangeDamChart,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}