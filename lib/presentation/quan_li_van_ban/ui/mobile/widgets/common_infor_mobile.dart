import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/chart/status_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonInformationMobile extends StatefulWidget {
  final DocumentDashboardModel documentDashboardModel;
  final String? title;
  final bool isVbDen;
  final QLVBCCubit qlvbcCubit;
  final Function(String) ontap;

  const CommonInformationMobile({
    Key? key,
    required this.documentDashboardModel,
    required this.qlvbcCubit,
    this.title,
    required this.isVbDen,
    required this.ontap,
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
          tittleStyle: textNormalCustom(
            color: textTitle,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          chartData: widget.isVbDen
              ? widget.qlvbcCubit.chartDataVbDen
              : widget.qlvbcCubit.chartDataVbDi,
          onTap: (int value) {
            if (widget.isVbDen) {
              widget.ontap(
                widget.qlvbcCubit.chartDataVbDen[value].title
                    .split(' ')
                    .join('_')
                    .toUpperCase()
                    .vietNameseParse(),
              );
            } else {
              widget.ontap(
                widget.qlvbcCubit.chartDataVbDi[value].title
                    .split(' ')
                    .join('_')
                    .toUpperCase()
                    .vietNameseParse(),
              );
            }
          },
        ),
        Container(height: 20),
        if (widget.isVbDen)
          StatusWidget(
            showZeroValue: false,
            listData: [
              ChartData(
                S.current.qua_han,
                widget.documentDashboardModel.soLuongQuaHan?.toDouble() ?? 0.0,
                statusCalenderRed,
              ),
              ChartData(
                S.current.den_han,
                widget.documentDashboardModel.soLuongDenHan?.toDouble() ?? 0.0,
                textColorForum,
              ),
              ChartData(
                S.current.trong_han,
                widget.documentDashboardModel.soLuongTrongHan?.toDouble() ??
                    0.0,
                choTrinhKyColor,
              )
            ],
          )
      ],
    );
  }
}
