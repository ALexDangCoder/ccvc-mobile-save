import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';
class XuLyWidget extends StatefulWidget {
  const XuLyWidget({Key? key}) : super(key: key);

  @override
  _XuLyWidgetState createState() => _XuLyWidgetState();
}

class _XuLyWidgetState extends State<XuLyWidget> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      paddingTop: 0,
      title: S.current.xu_ly,
      chartData: [
        ChartData(
          S.current.cho_tiep_nhan_xu_ly,
          14,
          choTrinhKyColor,
        ),
        ChartData(
          S.current.cho_xu_ly,
          14,
          numberOfCalenders,
        ),
        ChartData(
          S.current.cho_phan_xu_ly,
          14,
          radioFocusColor,
        ),
        ChartData(
          S.current.cho_duyet,
          14,
          choCapSoColor,
        ),
        ChartData(
          S.current.da_phan_cong,
          14,
          choBanHanhColor,
        ),
        ChartData(
          S.current.da_hoan_thanh,
          14,
          itemWidgetUsing,
        ),
      ],
    );
  }
}
