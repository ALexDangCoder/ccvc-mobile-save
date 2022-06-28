import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/to_chuc_boi_don_vi_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartByMeetingNumberWidget extends StatelessWidget {
  final CalendarMeetingCubit cubit;

  const ChartByMeetingNumberWidget({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToChucBoiDonViModel>>(
      stream: cubit.toChucBoiDonViStream,
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
                    minorGridLines: const MinorGridLines(width: 0),
                    minorTickLines: const MinorTickLines(
                      size: 0,
                      width: 0,
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
                    interval: cubit.getMax(data),
                    minimum: 0,
                    majorGridLines: const MajorGridLines(
                      width: 0.34,
                      color: AqiColor,
                      dashArray: [5, 5],
                    ),
                  ),
                  series: <ChartSeries<ToChucBoiDonViModel, String>>[
                    BarSeries<ToChucBoiDonViModel, String>(
                      color: bgrChart,
                      width: 0.5,
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
                      xValueMapper: (ToChucBoiDonViModel data, _) =>
                          data.tenDonVi,
                      yValueMapper: (ToChucBoiDonViModel data, _) =>
                          data.quantities,
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