import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/char_pakn/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class XuLyWidget extends StatefulWidget {
  const XuLyWidget({Key? key, required this.model}) : super(key: key);
  final DocumentDashboardModel model;
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
          widget.model.soLuongChoTiepNhanXuLy.toDouble(),
          choTrinhKyColor,
        ),
        ChartData(
          S.current.cho_xu_ly,
          widget.model.soLuongChoXuLy.toDouble(),
          numberOfCalenders,
        ),
        ChartData(
          S.current.cho_phan_xu_ly,
          widget.model.soLuongChoPhanXuLy.toDouble(),
          radioFocusColor,
        ),
        ChartData(
          S.current.cho_duyet,
          widget.model.soLuongChoDuyet.toDouble(),
          choCapSoColor,
        ),
        ChartData(
          S.current.da_phan_cong,
          widget.model.soLuongDaPhanCong.toDouble(),
          choBanHanhColor,
        ),
        ChartData(
          S.current.da_hoan_thanh,
          widget.model.soLuongDaHoanThanh.toDouble(),
          itemWidgetUsing,
        ),
      ],
    );
  }
}
