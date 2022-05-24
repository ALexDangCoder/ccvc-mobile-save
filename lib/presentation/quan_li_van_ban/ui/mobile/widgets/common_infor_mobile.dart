import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/chart/status_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonInformationMobile extends StatefulWidget {
  final DocumentDashboardModel? documentDashboardModel;
  final String? title;
  final Function(String) onPieTap;
  final List<ChartData> chartData;

  const CommonInformationMobile({
    Key? key,
    this.documentDashboardModel,
    this.title,
    required this.onPieTap,
    required this.chartData,
  }) : super(key: key);

  @override
  _CommonInformationMobileState createState() =>
      _CommonInformationMobileState();
}

class _CommonInformationMobileState extends State<CommonInformationMobile> {
  int selectedIndex = -1;

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
          chartData: List.generate(
            widget.chartData.length,
            (index) => ChartData(
              widget.chartData[index].title,
              widget.chartData[index].value,
              (selectedIndex != index && selectedIndex != -1)
                  ? widget.chartData[index].color.withOpacity(0.2)
                  : widget.chartData[index].color,
              size: selectedIndex == index ? '85%' : null,
            ),
          ),
          onTap: (int value) {
            selectedIndex = selectedIndex == value ? -1 : value;
            widget.onPieTap(
              getCodeFromTitlePieChart(widget.chartData[value].title),
            );
            setState(() {});
          },
        ),
        Container(height: 20),
        if (widget.documentDashboardModel != null)
          StatusWidget(
            showZeroValue: false,
            listData: [
              ChartData(
                S.current.qua_han,
                widget.documentDashboardModel?.soLuongQuaHan?.toDouble() ?? 0.0,
                statusCalenderRed,
              ),
              ChartData(
                S.current.den_han,
                widget.documentDashboardModel?.soLuongDenHan?.toDouble() ?? 0.0,
                textColorForum,
              ),
              ChartData(
                S.current.trong_han,
                widget.documentDashboardModel?.soLuongTrongHan?.toDouble() ??
                    0.0,
                choTrinhKyColor,
              )
            ],
          )
      ],
    );
  }
}
