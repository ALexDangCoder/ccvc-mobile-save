import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class CommonInformationTablet extends StatefulWidget {
  final DocumentDashboardModel documentDashboardModel;
  final String? title;
  final bool isVbDen;
  final QLVBCCubit qlvbcCubit;
  final Function(String) ontap;

  const CommonInformationTablet({
    Key? key,
    required this.documentDashboardModel,
    required this.qlvbcCubit,
    this.title,
    required this.isVbDen,
    required this.ontap,
  }) : super(key: key);

  @override
  _CommonInformationTabletState createState() =>
      _CommonInformationTabletState();
}

class _CommonInformationTabletState extends State<CommonInformationTablet> {
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
            chartData: widget.isVbDen
                ? widget.qlvbcCubit.chartDataVbDen
                : widget.qlvbcCubit.chartDataVbDi,
            onTap: (int value) {
              if (widget.isVbDen) {
                widget.ontap(widget.qlvbcCubit.chartDataVbDen[value].title
                    .split(' ')
                    .join('_')
                    .toUpperCase()
                    .vietNameseParse());
              } else {
                widget.ontap(widget.qlvbcCubit.chartDataVbDi[value].title
                    .split(' ')
                    .join('_')
                    .toUpperCase()
                    .vietNameseParse());
              }
            },
          ),
          Container(height: 20),
          if (widget.isVbDen)
            Row(
              children: [
                Expanded(
                  child: BoxStatusVanBan(
                    value: widget.documentDashboardModel.soLuongTrongHan ?? 0,
                    onTap: () {},
                    color: color5A8DEE,
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
                    color: colorEA5455,
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
                    color: colorFF9F43,
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
                color: colorFF9F43,
                statusName: S.current.thuong_khan,
              ),
            ),
        ],
      ),
    );
  }
}
