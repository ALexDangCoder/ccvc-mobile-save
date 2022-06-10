import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/char_pakn/document_dashboard_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

import 'bao_cao_thong_ke/status_widget.dart';
import 'status_pakn.dart';

class TiepCanWidget extends StatefulWidget {
  const TiepCanWidget({Key? key, required this.model}) : super(key: key);
  final DocumentDashboardModel model;
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
                S.current.cho_trinh_ky,
                widget.model.soLuongChoTrinhKy.toDouble(),
                choTrinhKyColor,
              ),
              ChartData(
                S.current.cho_xu_ly,
                widget.model.soLuongChoXuLy.toDouble(),
                color5A8DEE,
              ),
              ChartData(
                S.current.da_xu_ly,
                widget.model.soLuongDaXuLy.toDouble(),
                daXuLyColor,
              ),
              ChartData(
                S.current.cho_cap_so,
                widget.model.soLuongChoCapSo.toDouble(),
                choCapSoColor,
              ),
              ChartData(
                S.current.cho_ban_hanh,
                widget.model.soLuongChoBanHanh.toDouble(),
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
              widget.model.soLuongQuaHan.toDouble(),
              statusCalenderRed,
            ),
            ChartData(
              S.current.den_han,
              widget.model.soLuongDenHan.toDouble(),
              yellowColor,
            ),
            ChartData(
              S.current.trong_han,
              widget.model.soLuongTrongHan.toDouble(),
              choTrinhKyColor,
            ),
          ],
        ),
      ],
    );
  }
}
