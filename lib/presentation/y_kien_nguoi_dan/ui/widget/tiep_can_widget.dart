import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

import 'bao_cao_thong_ke/status_widget.dart';
import 'status_pakn.dart';

class TiepCanWidget extends StatefulWidget {
  const TiepCanWidget({Key? key, required this.model}) : super(key: key);
  final DashBoardPAKNModel model;
  @override
  _TiepCanWidgetState createState() => _TiepCanWidgetState();
}

class _TiepCanWidgetState extends State<TiepCanWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Text(
            S.current.tiep_nhan,
            style: textNormalCustom(
              color: dateColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Stack(
          children: [
            SizedBox(
              height: 260,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  8,
                  (index) => const MySeparator(
                    color: colorECEEF7,
                    height: 2,
                  ),
                ),
              ),
            ),
            statusWidget([
              ChartData(
                S.current.cho_tiep_nhan,
                widget.model.dashBoardTiepNhanPAKNModel.choTiepNhan.toDouble(),
                choTrinhKyColor,
              ),
              ChartData(
                S.current.phan_xu_ly,
                widget.model.dashBoardTiepNhanPAKNModel.phanXuLy.toDouble(),
                color5A8DEE,
              ),
              ChartData(
                S.current.dang_xu_ly,
                widget.model.dashBoardTiepNhanPAKNModel.dangXuLy.toDouble(),
                daXuLyColor,
              ),
              ChartData(
                S.current.cho_duyet,
                widget.model.dashBoardTiepNhanPAKNModel.choDuyet.toDouble(),
                choCapSoColor,
              ),
              ChartData(
                S.current.cho_bo_sung_thong_tin,
                widget.model.dashBoardTiepNhanPAKNModel.choBoSungThongTin.toDouble(),
                choBanHanhColor,
              )
            ]),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        StatusWidget(
          listData: [
            ChartData(
              S.current.qua_han,
              widget.model.dashBoardHanXuLyPAKNModel.quaHan.toDouble(),
              statusCalenderRed,
            ),
            ChartData(
              S.current.den_han,
              widget.model.dashBoardHanXuLyPAKNModel.denHan.toDouble(),
              yellowColor,
            ),
            ChartData(
              S.current.trong_han,
              widget.model.dashBoardHanXuLyPAKNModel.trongHan.toDouble(),
              choTrinhKyColor,
            ),
          ],
        ),
      ],
    );
  }
}
