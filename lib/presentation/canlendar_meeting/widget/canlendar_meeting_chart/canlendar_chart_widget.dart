import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/bloc/calendar_meeting_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/calendar_chart_by_time.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/canlender_chart_by_meeting_number.dart';
import 'package:ccvc_mobile/presentation/canlendar_meeting/widget/canlendar_meeting_chart/lich_hop_theo_linh_vuc.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class ThongKeLichHopScreen extends StatefulWidget {
  final CalendarMeetingCubit cubit;

  const ThongKeLichHopScreen({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  _ThongKeLichHopScreenState createState() => _ThongKeLichHopScreenState();
}

class _ThongKeLichHopScreenState extends State<ThongKeLichHopScreen> {
  @override
  void initState() {
    super.initState();
    widget.cubit.getDataDangChart();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textviewTitle(S.current.so_lich_hop_theo_thoi_gian_trong_nam),
          ChartByTimeWidget(cubit: widget.cubit),
          Container(
            width: double.maxFinite,
            height: 6,
            color: homeColor,
          ),
          textviewTitle(S.current.so_lich_hop_duoc_to_chuc_boi_cac_don_vi),
          ChartByMeetingNumberWidget(
            cubit: widget.cubit,
          ),
          Container(
            width: double.maxFinite,
            height: 6,
            color: homeColor,
          ),
          textviewTitle(S.current.co_cau_lich_hop),
          coCauLichHop(),
          Container(
            width: double.maxFinite,
            height: 6,
            color: homeColor,
          ),
          textviewTitle(S.current.so_lich_hop_theo_linh_vuc),
          ThongKeTheoLinhVuc(
            cubit: widget.cubit,
          ),
        ],
      ),
    );
  }

  Widget coCauLichHop(){
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
            useVerticalLegend: true,
            chartData: data,
            onTap: (value) {
              widget.cubit.handleChartPicked(
                id: data[value].id ?? '',
                title: data[value].title,
              );
            },
            isThongKeLichHop: false,
          );
        },
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
          fontSize: 16,
        ),
      ),
    );
  }
}
