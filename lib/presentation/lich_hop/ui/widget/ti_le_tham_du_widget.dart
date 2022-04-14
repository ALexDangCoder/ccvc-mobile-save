import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/ti_le_tham_gia.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/lich_hop/bloc/lich_hop_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TiLeThamDuWidget extends StatelessWidget {
  final LichHopCubit cubit;

  const TiLeThamDuWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TiLeThamGiaModel>>(
      stream: cubit.tiLeThamGiaSubject.stream,
      builder: (context, snapshot) {
        final data = snapshot.data ?? [];
        return cubit.checkDataRateList(data)
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
                    interval: cubit.getMaxTiLe(data),
                    minimum: 0,
                    majorGridLines: const MajorGridLines(
                      width: 0.34,
                      color: AqiColor,
                      dashArray: [5, 5],
                    ),
                  ),
                  series: <ChartSeries<TiLeThamGiaModel, String>>[
                    BarSeries<TiLeThamGiaModel, String>(
                      color: itemWidgetUsing,
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
                      width: 0.5,
                      dataSource: data,
                      xValueMapper: (TiLeThamGiaModel data, _) => data.tenDonVi,
                      yValueMapper: (TiLeThamGiaModel data, _) =>
                          (data.rate ?? 0).truncateToDecimalPlaces(2),
                    ),
                  ],
                ),
              )
            : Container(
                margin: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.current.khong_co_du_lieu,
                    )
                  ],
                ),
              );
      },
    );
  }
}
