import 'package:ccvc_mobile/home_module/config/resources/color.dart';
import 'package:ccvc_mobile/home_module/config/resources/styles.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/status_column_chart.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/widgets/status_widget.dart';
import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class TinhHinhPAKNCuaCaNhanMobileWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const TinhHinhPAKNCuaCaNhanMobileWidget(
      {Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<TinhHinhPAKNCuaCaNhanMobileWidget> createState() =>
      _SituationOfHandlingPeopleWidgetState();
}

class _SituationOfHandlingPeopleWidgetState
    extends State<TinhHinhPAKNCuaCaNhanMobileWidget> {
  final TinhHinhXuLyPAKNCubit _yKienCubit = TinhHinhXuLyPAKNCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _yKienCubit.callApi(isDonVi: false);

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _yKienCubit.callApi(isDonVi: false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 420,
      title: S.current.tinh_hinh_pakn_ca_nhan,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isShowSubTitle: false,
      selectKeyDialog: _yKienCubit,
      child: LoadingOnly(
        stream: _yKienCubit.stateStream,
        child: StreamBuilder<DocumentDashboardModel>(
            stream: _yKienCubit.getTinhHinhXuLy,
            builder: (context, snapshot) {
              final data = snapshot.data ?? DocumentDashboardModel();

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
                  StatusColumnChart(listData: [
                    ChartData(
                      S.current.cho_tiep_nhan,
                      data.soLuongChoTiepNhan.toDouble(),
                      choTrinhKyColor,
                      SelectKey.CHO_TRINH_KY,
                    ),
                    ChartData(
                      S.current.phan_xu_ly,
                      data.soLuongPhanXuLy.toDouble(),
                      numberOfCalenders,
                      SelectKey.CHO_XU_LY,
                    ),
                    ChartData(
                      S.current.dang_xu_ly,
                      data.soLuongDangXuLy.toDouble(),
                      daXuLyColor,
                      SelectKey.DA_XU_LY,
                    ),
                    ChartData(
                      S.current.cho_duyet,
                      data.soLuongChoDuyet.toDouble(),
                      choCapSoColor,
                      SelectKey.CHO_CAP_SO,
                    ),
                    ChartData(
                      S.current.cho_bo_sung_thong_tin,
                      data.soLuongChoBoSungThongTin.toDouble(),
                      choBanHanhColor,
                      SelectKey.CHO_BAN_HANH,
                    )
                  ]),
                  const SizedBox(
                    height: 24,
                  ),
                  StatusWidget(
                    showZeroValue: false,
                    listData: [
                      ChartData(
                        S.current.qua_han,
                        data.soLuongQuaHan.toDouble(),
                        statusCalenderRed,
                        SelectKey.CHO_VAO_SO,
                      ),
                      ChartData(
                        S.current.den_han,
                        data.soLuongDenHan.toDouble(),
                        yellowColor,
                        SelectKey.DANG_XU_LY,
                      ),
                      ChartData(
                        S.current.trong_han,
                        data.soLuongTrongHan.toDouble(),
                        choTrinhKyColor,
                        SelectKey.DA_XU_LY,
                      ),
                    ],
                  ),
                  PieChart(
                    title: S.current.xu_ly,
                    chartData: [
                      ChartData(
                        S.current.cho_tiep_nhan_xu_ly,
                        data.soLuongChoTiepNhanXuLy.toDouble(),
                        choTrinhKyColor,
                      ),
                      ChartData(
                        S.current.cho_xu_ly,
                        data.soLuongChoXuLy.toDouble(),
                        numberOfCalenders,
                      ),
                      ChartData(
                        S.current.cho_phan_xu_ly,
                        data.soLuongChoPhanXuLy.toDouble(),
                        radioFocusColor,
                      ),
                      ChartData(
                        S.current.cho_duyet,
                        data.soLuongChoDuyetXuLy.toDouble(),
                        choCapSoColor,
                      ),
                      ChartData(
                        S.current.da_phan_cong,
                        data.soLuongDaPhanCong.toDouble(),
                        choBanHanhColor,
                      ),
                      ChartData(
                        S.current.da_hoan_thanh,
                        data.soLuongDaHoanThanh.toDouble(),
                        itemWidgetUsing,
                      ),
                    ],
                  )
                ],
              );
              // return PieChart(
              //   chartData: List.generate(
              //     data.length,
              //     (index) {
              //       final result = data[index];
              //       final color = TinhHinhYKienModel.listColor[index];
              //       return ChartData(
              //         result.status,
              //         result.soLuong.toDouble(),
              //         color,
              //       );
              //     },
              //   ),
              //   onTap: (value, key) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => DanhSachYKND(
              //           endDate: _yKienCubit.endDate.toString(),
              //           startDate: _yKienCubit.startDate.toString(),
              //         ),
              //       ),
              //     );
              //   },
              // );
            }),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
