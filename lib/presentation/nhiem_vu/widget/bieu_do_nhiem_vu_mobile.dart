import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/domain/model/nhiem_vu/nhiem_vu_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class BieuDoNhiemVuMobile extends StatefulWidget {
  final NhiemVuDashBoardModel nhiemVuDashBoardModel;
  final String? title;
  final List<ChartData> chartData;


  const BieuDoNhiemVuMobile({
    Key? key,
    required this.nhiemVuDashBoardModel,
    required this.chartData,
    this.title,
  }) : super(key: key);

  @override
  _BieuDoNhiemVuMobileState createState() =>
      _BieuDoNhiemVuMobileState();
}

class _BieuDoNhiemVuMobileState extends State<BieuDoNhiemVuMobile> {


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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PieChart(
            title: widget.title ?? '',
            chartData:widget.chartData,
            onTap: (int value) {},
          ),
          Container(height: 20),
            Row(
              children: [
                Expanded(
                  child: BoxStatusVanBan(
                    value:
                    widget.nhiemVuDashBoardModel.soLuongTrongHan??0,
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
                    value: widget.nhiemVuDashBoardModel.soLuongQuaHan
                        ??0,
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
                    value: widget.nhiemVuDashBoardModel.soLuongDenHan??0,
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
