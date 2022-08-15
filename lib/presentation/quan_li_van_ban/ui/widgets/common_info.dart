import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/extensions/common_ext.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/chart/status_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonInformationDocumentManagement extends StatefulWidget {
  final DocumentDashboardModel? documentDashboardModel;
  final String? title;
  final Function(String) onPieTap;
  final List<ChartData> chartData;
  final bool isTablet;
  final Function(String) onStatusTap;
  final bool isPaddingTop;

  const CommonInformationDocumentManagement({
    Key? key,
    this.documentDashboardModel,
    this.title,
    required this.onPieTap,
    required this.chartData,
    this.isTablet = false,
    required this.onStatusTap,
    this.isPaddingTop = true
  }) : super(key: key);

  @override
  _CommonInformationDocumentManagementState createState() =>
      _CommonInformationDocumentManagementState();
}

class _CommonInformationDocumentManagementState extends State<CommonInformationDocumentManagement> {
  int selectedIndex = -1;
  String sKey = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PieChart(
          isVectical: !widget.isTablet,
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
            sKey = '';
            selectedIndex = selectedIndex == value ? -1 : value;
            widget.onPieTap(
              getCodeFromTitlePieChart(widget.chartData[value].title),
            );
            setState(() {});
          },
        ),
        Container(height:widget.isPaddingTop ? 20 : 0),
        if (widget.documentDashboardModel != null)
          StatusWidget(
            key: UniqueKey(),
            selectedKey: sKey,
            showZeroValue: false,
            horizontalView: widget.isTablet,
            onSelectItem: (e) {
              widget.onStatusTap(e);
              sKey = e;
              selectedIndex = -1;
              setState(() {});
            },
            listData: [
              ChartData(
                S.current.qua_han,
                widget.documentDashboardModel?.soLuongQuaHan?.toDouble() ?? 0.0,
                statusCalenderRed,
                key: DocumentState.QUA_HAN,
              ),
              ChartData(
                S.current.den_han,
                widget.documentDashboardModel?.soLuongDenHan?.toDouble() ?? 0.0,
                textColorForum,
                key: DocumentState.DEN_HAN,
              ),
              ChartData(
                S.current.trong_han,
                widget.documentDashboardModel?.soLuongTrongHan?.toDouble() ??
                    0.0,
                choTrinhKyColor,
                key: DocumentState.TRONG_HAN,
              )
            ],
          )
      ],
    );
  }
}
