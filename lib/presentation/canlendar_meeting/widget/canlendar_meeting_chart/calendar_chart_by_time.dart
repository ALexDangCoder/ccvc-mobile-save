import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/statistic_by_month_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartByTimeWidget extends StatelessWidget {
  final CalendarMeetingCubit cubit;
  const ChartByTimeWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<List<StatisticByMonthModel>>(
        stream: cubit.statisticStream,
        builder: (context, snapshot) {
          final dataByMonth = snapshot.data ?? [];
          return Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 600,
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
                      fontSize: 12.0.textScale(space: 4),
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
                      fontSize: 12.0.textScale(space: 4),
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
                  series: <ChartSeries<StatisticByMonthModel, int>>[
                    StackedLineSeries<StatisticByMonthModel, int>(
                      color: color5A8DEE,
                      dataSource: dataByMonth,
                      xValueMapper: (StatisticByMonthModel sales, _) => sales.month,
                      yValueMapper: (StatisticByMonthModel sales, _) =>
                      sales.quantities,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: textNormalCustom(
                          color: infoColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0.textScale(space: 4),
                        ),
                        labelAlignment: ChartDataLabelAlignment.outer,
                      ),
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        color: color5A8DEE,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
