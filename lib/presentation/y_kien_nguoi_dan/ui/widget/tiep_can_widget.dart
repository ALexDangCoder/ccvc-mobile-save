import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

import 'bao_cao_thong_ke/status_widget.dart';
import 'status_pakn.dart';

class TiepCanWidget extends StatefulWidget {
  const TiepCanWidget(
      {Key? key,
      required this.model,
      required this.cubit,
      this.isTablet = false})
      : super(key: key);
  final DashBoardPAKNModel model;
  final YKienNguoiDanCubitt cubit;
  final bool? isTablet;

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
            statusWidget(
              isTablet: widget.isTablet,
              listData: [
                ChartData(
                  S.current.cho_tiep_nhan,
                  widget.model.dashBoardTiepNhanPAKNModel.choTiepNhan
                      .toDouble(),
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
                  widget.model.dashBoardTiepNhanPAKNModel.choBoSungThongTin
                      .toDouble(),
                  choBanHanhColor,
                )
              ],
              callBack: (index) {
                ///cho tiep nhan 0
                ///phan xu ly 1
                ///dang xu ly 2
                ///cho duyet 3
                ///cho bo sung tt 4
                widget.cubit.getPaknTiepCan(index);
              },
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        StatusWidget(
          isTablet: widget.isTablet,
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
          callBack: (index1) {
            ///qua han 0
            ///den han 1
            ///trong han 2
            if (index1 == 0) {
              widget.cubit.hanXuLy = -1;
              widget.cubit.loaiMenu = null;
              widget.cubit.trangThaiFilter = null;
              widget.cubit.textFilter.add(
                TextTrangThai(
                  S.current.qua_han,
                  statusCalenderRed,
                ),
              );
              widget.cubit.isShowFilterList.add(false);
              widget.cubit.setColorWhenChooseDropDown(
                  YKienNguoiDanCubitt.INDEX_FILTER_OUT_RANGE);
              widget.cubit.getDanhSachPAKNFilterChart();
            } else if (index1 == 1) {
              widget.cubit.hanXuLy = 0;
              widget.cubit.loaiMenu = null;
              widget.cubit.trangThaiFilter = null;
              widget.cubit.textFilter.add(
                TextTrangThai(
                  S.current.den_han,
                  yellowColor,
                ),
              );
              widget.cubit.isShowFilterList.add(false);
              widget.cubit.setColorWhenChooseDropDown(
                  YKienNguoiDanCubitt.INDEX_FILTER_OUT_RANGE);
              widget.cubit.getDanhSachPAKNFilterChart();
            } else {
              widget.cubit.hanXuLy = 1;
              widget.cubit.loaiMenu = null;
              widget.cubit.trangThaiFilter = null;
              widget.cubit.textFilter.add(
                TextTrangThai(
                  S.current.trong_han,
                  choTrinhKyColor,
                ),
              );
              widget.cubit.isShowFilterList.add(false);
              widget.cubit.setColorWhenChooseDropDown(
                  YKienNguoiDanCubitt.INDEX_FILTER_OUT_RANGE);
              widget.cubit.getDanhSachPAKNFilterChart();
            }
          },
        ),
      ],
    );
  }
}
