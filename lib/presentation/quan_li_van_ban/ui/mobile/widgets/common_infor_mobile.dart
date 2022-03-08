import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class CommonInformationMobile extends StatefulWidget {
  final DocumentDashboardModel documentDashboardModel;
  final String? title;
  final bool isVbDen;
  final QLVBCCubit qlvbcCubit;

  const CommonInformationMobile({
    Key? key,
    required this.documentDashboardModel,
    required this.qlvbcCubit,
    this.title,
    required this.isVbDen,
  }) : super(key: key);

  @override
  _CommonInformationMobileState createState() =>
      _CommonInformationMobileState();
}

class _CommonInformationMobileState extends State<CommonInformationMobile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PieChart(
          title: widget.title ?? '',
          chartData: widget.isVbDen
              ? widget.qlvbcCubit.chartDataVbDen
              : widget.qlvbcCubit.chartDataVbDi,
          onTap: (int value) {},
        ),
        Container(height: 20),
        if (widget.isVbDen)
          Row(
            children: [
              Expanded(
                child: BoxStatusVanBan(
                  value: widget.documentDashboardModel.soLuongTrongHan ?? 0,
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
                  value: widget.documentDashboardModel.soLuongQuaHan ?? 0,
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
                  value: widget.documentDashboardModel.soLuongThuongKhan ?? 0,
                  onTap: () {},
                  color: textColorForum,
                  statusName: S.current.thuong_khan,
                ),
              ),
            ],
          )
        else
          SizedBox(
            width: 103,
            child: BoxStatusVanBan(
              value: widget.documentDashboardModel.soLuongThuongKhan ?? 0,
              onTap: () {},
              color: textColorForum,
              statusName: S.current.thuong_khan,
            ),
          ),
      ],
    );
  }
}


