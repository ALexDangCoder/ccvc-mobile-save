import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/bloc/bao_cao_thong_ke_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartLinhVucXuLyWidget extends StatelessWidget {
  final BaoCaoThongKeYKNDCubit cubit;

  const ChartLinhVucXuLyWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LinhVucKhacModel>>(
      stream: cubit.chartLinhVucXuLy,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return cubit.checkDataList(data)
            ? SizedBox(
                height: 70.0 * data.length,
                child: SfCartesianChart(
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
                    maximumLabelWidth: 90,
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
                  series: <ChartSeries<LinhVucKhacModel, String>>[
                    BarSeries<LinhVucKhacModel, String>(
                      color: bgrChart,
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
                      dataSource: data,
                      xValueMapper: (LinhVucKhacModel data, _) =>
                          data.tenLinhVuc,
                      yValueMapper: (LinhVucKhacModel data, _) =>
                          data.soPhanAnhKienNghi,
                    ),
                  ],
                ),
              )
            : const Center(
                child: NodataWidget(),
              );
      },
    );
  }
}
