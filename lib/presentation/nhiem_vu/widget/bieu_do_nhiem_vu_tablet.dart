import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class BieuDoNhiemVuTablet extends StatefulWidget {
  final DocumentDashboardModel documentDashboardModel;
  final String? title;
  final List<ChartData> chartData;

  const BieuDoNhiemVuTablet({
    Key? key,
    required this.documentDashboardModel,
    this.title,
    required this.chartData,
  }) : super(key: key);

  @override
  _BieuDoNhiemVuTabletState createState() =>
      _BieuDoNhiemVuTabletState();
}

class _BieuDoNhiemVuTabletState extends State<BieuDoNhiemVuTablet> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PieChart(
            title: widget.title ?? '',
            chartData: widget.chartData,
            onTap: (int value) {},
          ),
          Container(height: 20),
            Row(
              children: [
                Expanded(
                  child: BoxStatusVanBan(
                    value: widget.documentDashboardModel.soLuongTrongHan??0,
                    onTap: () {},
                    color: numberOfCalenders,
                    statusName: S.current.trong_han,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BoxStatusVanBan(
                    value:
                    widget.documentDashboardModel.soLuongQuaHan??0,
                    onTap: () {},
                    color: statusCalenderRed,
                    statusName: S.current.qua_han,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BoxStatusVanBan(
                    value: widget.documentDashboardModel.soLuongThuongKhan
                        ??0,
                    onTap: () {},
                    color: textColorForum,
                    statusName: S.current.thuong_khan,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            )

        ],
      ),
    );
  }
}
