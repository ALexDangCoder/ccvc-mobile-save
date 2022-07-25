import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/calendar_chart_by_time.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/canlender_chart_by_meeting_number.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/lich_hop_theo_linh_vuc.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class ThongKeLichHopTablet extends StatefulWidget {
  final CalendarMeetingCubit cubit;

  const ThongKeLichHopTablet({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ThongKeLichHopTablet> createState() => _ThongKeLichHopTabletState();
}

class _ThongKeLichHopTabletState extends State<ThongKeLichHopTablet> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getDataDangChart();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 28,
              mainAxisSpacing: 28,
              shrinkWrap: true,
              childAspectRatio: 4 / 5,
              children: [
                containerChart(
                  children: [
                    textviewTitle(
                      S.current.so_lich_hop_theo_thoi_gian_trong_nam,
                    ),
                    ChartByTimeWidget(cubit: widget.cubit),
                  ],
                ),
                containerChart(
                  children: [
                    textviewTitle(S.current.so_lich_hop_duoc_to_chuc_boi_cac_don_vi,),
                    ChartByMeetingNumberWidget(
                      cubit: widget.cubit,
                    ),
                  ],
                ),
                containerChart(
                  children: [
                    textviewTitle(S.current.co_cau_lich_hop),
                    coCauLichHop(),
                  ],
                ),
                containerChart(
                  children: [
                    textviewTitle(
                      S.current.ti_le_tham_du_cua_cac_don_vi,
                    ),
                    ThongKeTheoLinhVuc(
                      cubit: widget.cubit,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget coCauLichHop() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: StreamBuilder<List<ChartData>>(
        stream: widget.cubit.coCauLichHopStream,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          return PieChart(
            chartData: data,
            useVerticalLegend: true,
            isThongKeLichHop: false,
          );
        },
      ),
    );
  }

  Widget containerChart({
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowContainerColor.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget textviewTitle(String title) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Text(
        title,
        style: textNormalCustom(
          color: textTitle,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}
