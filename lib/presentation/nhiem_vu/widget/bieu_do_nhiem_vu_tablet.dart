import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/nhiem_vu_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class BieuDoNhiemVuTablet extends StatefulWidget {
  final NhiemVuDashBoardModel nhiemVuDashboardModel;
  final String? title;
  final List<ChartData> chartData;

  const BieuDoNhiemVuTablet({
    Key? key,
    required this.nhiemVuDashboardModel,
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
      padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
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
<<<<<<< HEAD
                    value: widget.documentDashboardModel.soLuongTrongHan??0,
=======
                    value: widget.nhiemVuDashboardModel.soLuongTrongHan??0,
>>>>>>> develop
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
<<<<<<< HEAD
                    widget.documentDashboardModel.soLuongQuaHan??0,
=======
                    widget.nhiemVuDashboardModel.soLuongQuaHan??0,
>>>>>>> develop
                    onTap: () {},
                    color: dangXyLyColor,
                    statusName: S.current.den_han,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BoxStatusVanBan(
<<<<<<< HEAD
                    value: widget.documentDashboardModel.soLuongThuongKhan
                        ??0,
=======
                    value: widget.nhiemVuDashboardModel.soLuongQuaHan??0,
>>>>>>> develop
                    onTap: () {},
                    color: statusCalenderRed,
                      statusName: S.current.qua_han,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
