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
  ChartByTimeWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamBuilder<List<StatisticByMonthModel>>(
        stream: cubit.statisticStream,
        builder: (context, snapshot) {
          final dataByMonth = snapshot.data ?? [];
          return Scrollbar(
            controller: _scrollController,
            isAlwaysShown: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Container(
                padding: const EdgeInsets.only(right: 30),
                width: 700,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.none,
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
                    labelAlignment: LabelAlignment.start,
                    interval: 1,
                    minimum: 0,
                    majorTickLines: const MajorTickLines(size: 0),
                    axisLine: const AxisLine(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorGridLines: const MajorGridLines(
                      width: 0.41,
                      dashArray: [5, 5],
                      color: colorA2AEBD,
                    ),
                    majorTickLines: const MajorTickLines(size: 0),
                    labelStyle: textNormalCustom(
                      color: AqiColor,
                      fontSize: 12.0.textScale(space: 4),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  series: <ChartSeries<StatisticByMonthModel, int>>[
                    StackedLineSeries<StatisticByMonthModel, int>(
                      color: color5A8DEE,
                      dataSource: dataByMonth,
                      xValueMapper: (StatisticByMonthModel sales, _) => sales.month,
                      yValueMapper: (StatisticByMonthModel sales, _) => sales.quantities,
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
