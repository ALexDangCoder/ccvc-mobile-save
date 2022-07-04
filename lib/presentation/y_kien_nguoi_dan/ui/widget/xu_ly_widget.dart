import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class XuLyWidget extends StatefulWidget {
  const XuLyWidget({Key? key, required this.model, required this.cubit})
      : super(key: key);
  final DashBoardPAKNModel model;
  final YKienNguoiDanCubitt cubit;

  @override
  _XuLyWidgetState createState() => _XuLyWidgetState();
}

class _XuLyWidgetState extends State<XuLyWidget> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      paddingTop: 0,
      title: S.current.xu_ly,
      onTap: (index) {
        ///0 cho tiep nhan xu ly
        ///1 cho xu ly
        ///2cho phan xu ly
        ///3 cho duyet
        ///4 da phan cong
        ///5 da thuc hien
        if (index == 0) {
          widget.cubit.hanXuLy = null;
          widget.cubit.loaiMenu = 'XuLy';
          widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.ChoTiepNhanXuLy;
          widget.cubit.textFilter.add(
            TextTrangThai(
              S.current.cho_tiep_nhan_xu_ly,
              AppTheme.getInstance().choXuLyColor(),
            ),
          );
          widget.cubit.isShowFilterList.add(false);
          widget.cubit.getDanhSachPAKNFilterChart();
        } else if (index == 1) {
          widget.cubit.hanXuLy = null;
          widget.cubit.loaiMenu = 'XuLy';
          widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.ChoXuLy;
          widget.cubit.textFilter.add(
            TextTrangThai(
              S.current.cho_xu_ly,
              textColorForum,
            ),
          );
          widget.cubit.isShowFilterList.add(false);
          widget.cubit.getDanhSachPAKNFilterChart();
        }else if (index == 2) {
          widget.cubit.hanXuLy = null;
          widget.cubit.loaiMenu = 'XuLy';
          widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.ChoPhanCongXuLy;
          widget.cubit.textFilter.add(
            TextTrangThai(
              S.current.cho_phan_cong_xu_ly,
              AppTheme.getInstance().choXuLyColor(),
            ),
          );
          widget.cubit.isShowFilterList.add(false);
          widget.cubit.getDanhSachPAKNFilterChart();
        }else if (index == 3) {
          widget.cubit.hanXuLy = null;
          widget.cubit.loaiMenu = 'XuLy';
          widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.ChoDuyet;
          widget.cubit.textFilter.add(
            TextTrangThai(
              S.current.cho_duyet,
              textColorForum,
            ),
          );
          widget.cubit.isShowFilterList.add(false);
          widget.cubit.getDanhSachPAKNFilterChart();
        }else if (index == 4) {
          widget.cubit.hanXuLy = null;
          widget.cubit.loaiMenu = 'XuLy';
          widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.DaPhanCong;
          widget.cubit.textFilter.add(
            TextTrangThai(
              S.current.da_phan_cong,
              daXuLyColor,
            ),
          );
          widget.cubit.isShowFilterList.add(false);
          widget.cubit.getDanhSachPAKNFilterChart();
        } else {
          widget.cubit.hanXuLy = null;
          widget.cubit.loaiMenu = 'XuLy';
          widget.cubit.trangThaiFilter = YKienNguoiDanCubitt.DaHoanThanh;
          widget.cubit.textFilter.add(
            TextTrangThai(
              S.current.da_hoan_thanh,
              greenChart,
            ),
          );
          widget.cubit.isShowFilterList.add(false);
          widget.cubit.getDanhSachPAKNFilterChart();
        }
      },
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
