import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/chart_pakn/dashboard_pakn_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/block/y_kien_nguoidan_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/subject_info_widget.dart';
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
    return Column(
      children: [
        PieChart(
          isSubjectInfo: false,
          paddingTop: 0,
          title: S.current.xu_ly,
          onTapPAKN: (index) {
            ///0 cho tiep nhan xu ly
            ///1 cho xu ly
            ///2cho phan xu ly
            ///3 cho duyet
            ///4 da phan cong
            ///5 da thuc hien
            widget.cubit.getPAKNXuLy(index);
          },
          chartData: [
            ChartData(
              S.current.cho_tiep_nhan_xu_ly,
              widget.model.dashBoardXuLyPAKNModelModel.choTiepNhanXuLy
                  .toDouble(),
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
        ),
        spaceH24,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.cubit.getPAKNXuLy(0);
                    },
                    child: SubjectInfoWidget(
                      color: choTrinhKyColor,
                      title: S.current.cho_tiep_nhan_xu_ly,
                      value: widget
                          .model.dashBoardXuLyPAKNModelModel.choTiepNhanXuLy
                          .toDouble(),
                    ),
                  ),
                ),
                spaceW6,
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: GestureDetector(
                      onTap: () {
                        widget.cubit.getPAKNXuLy(1);
                      },
                      child: SubjectInfoWidget(
                        color: numberOfCalenders,
                        title: S.current.cho_xu_ly,
                        value: widget.model.dashBoardXuLyPAKNModelModel.choXuLy
                            .toDouble(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            spaceH16,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.cubit.getPAKNXuLy(2);
                    },
                    child: SubjectInfoWidget(
                      color: radioFocusColor,
                      title: S.current.cho_phan_xu_ly,
                      value: widget
                          .model.dashBoardXuLyPAKNModelModel.choPhanXuLy
                          .toDouble(),
                    ),
                  ),
                ),
                spaceW6,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.cubit.getPAKNXuLy(3);
                    },
                    child: SubjectInfoWidget(
                      color: choCapSoColor,
                      title: S.current.cho_duyet,
                      value: widget.model.dashBoardXuLyPAKNModelModel.choDuyet
                          .toDouble(),
                    ),
                  ),
                ),
              ],
            ),
            spaceH16,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.cubit.getPAKNXuLy(4);
                    },
                    child: SubjectInfoWidget(
                      color: choBanHanhColor,
                      title: S.current.da_phan_cong,
                      value: widget.model.dashBoardXuLyPAKNModelModel.daPhanCong
                          .toDouble(),
                    ),
                  ),
                ),
                spaceW6,
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.cubit.getPAKNXuLy(5);
                    },
                    child: SubjectInfoWidget(
                      color: itemWidgetUsing,
                      title: S.current.da_hoan_thanh,
                      value: widget
                          .model.dashBoardXuLyPAKNModelModel.daHoanThanh
                          .toDouble(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
