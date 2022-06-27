import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class XuLyWidget extends StatefulWidget {
  const XuLyWidget({Key? key, required this.model}) : super(key: key);
  final DashBoardPAKNModel model;
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
          widget.model.dashBoardXuLyPAKNModelModel.choTiepNhanXuLy.toDouble(),
          choTrinhKyColor,
        ),
        ChartData(
          S.current.cho_xu_ly,
          widget.model.dashBoardXuLyPAKNModelModel.choXuLy.toDouble(),
          numberOfCalenders,
        ),
        ChartData(
          S.current.cho_phan_xu_ly,
          widget.model.dashBoardXuLyPAKNModelModel.choPhanXuLy.toDouble(),
          radioFocusColor,
        ),
        ChartData(
          S.current.cho_duyet,
          widget.model.dashBoardXuLyPAKNModelModel.choDuyet.toDouble(),
          choCapSoColor,
        ),
        ChartData(
          S.current.da_phan_cong,
          widget.model.dashBoardXuLyPAKNModelModel.daPhanCong.toDouble(),
          choBanHanhColor,
        ),
        ChartData(
          S.current.da_hoan_thanh,
          widget.model.dashBoardXuLyPAKNModelModel.daHoanThanh.toDouble(),
          itemWidgetUsing,
        ),
      ],
    );
  }
}
