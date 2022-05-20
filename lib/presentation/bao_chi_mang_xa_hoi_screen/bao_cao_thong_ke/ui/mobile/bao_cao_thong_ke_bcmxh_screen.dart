import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_caoThong_ke_bcmxh_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/bao_cao_theo_nguoi_line_chart.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/bao_cao_theo_sac_thai_line_chart.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/baocao_chart_item.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/bar_chart_bcmxh.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/indicator_widget.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/line_chart.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BaoCaoThongKeBCMXHScreen extends StatefulWidget {
  final int topic;

  const BaoCaoThongKeBCMXHScreen({Key? key, required this.topic})
      : super(key: key);

  @override
  State<BaoCaoThongKeBCMXHScreen> createState() =>
      _BaoCaoThongKeBCMXHScreenState();
}

class _BaoCaoThongKeBCMXHScreenState extends State<BaoCaoThongKeBCMXHScreen>
    with AutomaticKeepAliveClientMixin {
  BaoCaoThongKeBCMXHCubit baoCaoThongKeBCMXHCubit = BaoCaoThongKeBCMXHCubit();

  @override
  void initState() {
    super.initState();
    baoCaoThongKeBCMXHCubit.callApi(widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // setState(() {});
            await baoCaoThongKeBCMXHCubit.callApi(widget.topic);
          },
          child: StateStreamLayout(
            textEmpty: S.current.khong_co_du_lieu,
            retry: () {},
            error: AppException(
              S.current.error,
              S.current.error,
            ),
            stream: baoCaoThongKeBCMXHCubit.stateStream,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                key: UniqueKey(),
                children: [
                  GroupChartItemWidget(
                    onChoiceDate: (startDate, endDate) {
                      baoCaoThongKeBCMXHCubit.getTongQuanBaoCao(
                        startDate,
                        endDate,
                        widget.topic,
                      );
                    },
                    title: S.current.tong_quan,
                    child: StreamBuilder<Map<String, List<BarChartModel>>>(
                      stream: baoCaoThongKeBCMXHCubit.mapTongQuan,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? {};
                        final listData =
                            data[BaoCaoThongKeBCMXHCubit.KEY_TONG_QUAN];
                        final listStatusData =
                            data[BaoCaoThongKeBCMXHCubit.KEY_STATUS_TONG_QUAN];
                        return snapshot.hasData
                            ? data.isEmpty
                                ? const NodataWidget(
                                    height: 64,
                                  )
                                : Column(
                                    children: [
                                      BarCharWidget(
                                        color: color8E7EFF,
                                        listData: listData ?? [],
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      BarCharWidget(
                                        color: colorFF9F43,
                                        listData: listStatusData ?? [],
                                      ),
                                    ],
                                  )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    height: 6,
                    color: colorEEF3FF,
                  ),
                  StreamBuilder<List<List<BarChartModel>>>(
                    stream: baoCaoThongKeBCMXHCubit.listTinTongHop,
                    builder: (context, snapshot) {
                      final listData = snapshot.data ?? [];
                      return snapshot.hasData
                          ? listData.isNotEmpty
                              ? Column(
                                  children: [
                                    GroupChartItemWidget(
                                      onChoiceDate: (startDate, endDate) {
                                        baoCaoThongKeBCMXHCubit.getTinTongHop(
                                          startDate,
                                          endDate,
                                        );
                                      },
                                      title: S.current.tin_tong_hop,
                                      child: BarCharWidget(
                                        color: colorFF9F43,
                                        listData: listData[0],
                                        direction: true,
                                      ),
                                    ),
                                    Container(
                                      height: 6,
                                      color: colorEEF3FF,
                                    ),
                                    GroupChartItemWidget(
                                      onChoiceDate: (startDate, endDate) {
                                        baoCaoThongKeBCMXHCubit.getTinTongHop(
                                          startDate,
                                          endDate,
                                        );
                                      },
                                      title: S.current.cac_dia_phuong,
                                      child: BarCharWidget(
                                        color: color28C76F,
                                        listData: listData[1],
                                        direction: true,
                                      ),
                                    ),
                                    Container(
                                      height: 6,
                                      color: colorEEF3FF,
                                    ),
                                    GroupChartItemWidget(
                                      onChoiceDate: (startDate, endDate) {
                                        baoCaoThongKeBCMXHCubit.getTinTongHop(
                                          startDate,
                                          endDate,
                                        );
                                      },
                                      title: S.current.uy_ban_nhan_dan_tinh,
                                      child: BarCharWidget(
                                        color: colorFF9F43,
                                        listData: listData[2],
                                        direction: true,
                                      ),
                                    ),
                                    Container(
                                      height: 6,
                                      color: colorEEF3FF,
                                    ),
                                    GroupChartItemWidget(
                                      onChoiceDate: (startDate, endDate) {
                                        baoCaoThongKeBCMXHCubit.getTinTongHop(
                                          startDate,
                                          endDate,
                                        );
                                      },
                                      title: S.current.lanh_dao_tinh,
                                      child: BarCharWidget(
                                        color: colorFF9F43,
                                        listData: listData[3],
                                        direction: true,
                                      ),
                                    ),
                                  ],
                                )
                              : const NodataWidget(
                                  height: 64,
                                )
                          : const SizedBox.shrink();
                    },
                  ),
                  Container(
                    height: 6,
                    color: colorEEF3FF,
                  ),
                  GroupChartItemWidget(
                    onChoiceDate: (startDate, endDate) {
                      baoCaoThongKeBCMXHCubit.getBaoCaoTheoThoiGian(
                        startDate,
                        endDate,
                        widget.topic,
                      );
                    },
                    title: S.current.thong_ke_theo_thoi_gian,
                    child: StreamBuilder<List<LineChartData>>(
                      stream: baoCaoThongKeBCMXHCubit.lineChartTheoThoiGian,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return snapshot.hasData
                            ? data.isNotEmpty
                                ? LineChartWidget(
                                    listData: data,
                                  )
                                : const NodataWidget(
                                    height: 64,
                                  )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    height: 6,
                    color: colorEEF3FF,
                  ),
                  GroupChartItemWidget(
                    onChoiceDate: (startDate, endDate) {
                      baoCaoThongKeBCMXHCubit.getBaoCaoTheoNguon(
                        startDate,
                        endDate,
                        widget.topic,
                      );
                    },
                    title: S.current.thong_ke_theo_nguon_tin,
                    child: StreamBuilder<List<ChartData>>(
                      stream: baoCaoThongKeBCMXHCubit.chartBaoCaoTheoNguon,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return snapshot.hasData
                            ? data.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: PieChart(
                                          chartData: data,
                                          isSubjectInfo: false,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Center(
                                        child: Wrap(
                                          children: [
                                            ChartIndicatorWidget(
                                              title: S.current.mang_xa_hoi,
                                              color: colorFF9F43,
                                            ),
                                            ChartIndicatorWidget(
                                              title: S.current.bao_chi,
                                              color: color28C76F,
                                            ),
                                            ChartIndicatorWidget(
                                              title: S.current.forum,
                                              color: color667793,
                                            ),
                                            ChartIndicatorWidget(
                                              title: S.current.blog,
                                              color: colorFDB000,
                                            ),
                                            ChartIndicatorWidget(
                                              title: S.current.khac,
                                              color: color8E7EFF,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : const NodataWidget(
                                    height: 64,
                                  )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    height: 6,
                    color: colorEEF3FF,
                  ),
                  GroupChartItemWidget(
                    onChoiceDate: (startDate, endDate) {
                      baoCaoThongKeBCMXHCubit.getBaoCaoTheoSacThai(
                        startDate,
                        endDate,
                        widget.topic,
                      );
                    },
                    title: S.current.thong_ke_theo_sac_thai,
                    child: StreamBuilder<List<ChartData>>(
                      stream: baoCaoThongKeBCMXHCubit.chartBaoCaoTheoSacThai,
                      builder: (context, snapshot) {
                        final data = snapshot.data ?? [];
                        return snapshot.hasData
                            ? data.isNotEmpty
                                ? Column(
                                    children: [
                                      Center(
                                        child: PieChart(
                                          chartData: data,
                                          isSubjectInfo: false,
                                        ),
                                      ),
                                      Center(
                                        child: Wrap(
                                          children: [
                                            ChartIndicatorWidget(
                                              title: S.current.tich_cuc,
                                              color: color28C76F,
                                            ),
                                            ChartIndicatorWidget(
                                              title: S.current.trung_lap,
                                              color: colorFF9F43,
                                            ),
                                            ChartIndicatorWidget(
                                              title: S.current.tich_cuc,
                                              color: colorFF9F43,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : const NodataWidget(
                                    height: 64,
                                  )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                  Container(
                    height: 6,
                    color: colorEEF3FF,
                  ),
                  GroupChartItemWidget(
                    onChoiceDate: (startDate, endDate) {
                      baoCaoThongKeBCMXHCubit.getBaoCaoTheoNguonLineChart(
                        startDate,
                        endDate,
                        widget.topic,
                      );
                    },
                    title: S.current.bieu_do_theo_nguon,
                    child: Column(
                      children: [
                        LineChartTheoNguonWidget(
                          baoCaoThongKeBCMXHCubit: baoCaoThongKeBCMXHCubit,
                        ),
                        Center(
                          child: Wrap(
                            children: [
                              ChartIndicatorWidget(
                                title: S.current.mang_xa_hoi,
                                color: colorFF9F43,
                              ),
                              ChartIndicatorWidget(
                                title: S.current.bao_chi,
                                color: colorFF9F43,
                              ),
                              ChartIndicatorWidget(
                                title: S.current.forum,
                                color: color8E7EFF,
                              ),
                              ChartIndicatorWidget(
                                title: S.current.blog,
                                color: colorFDB000,
                              ),
                              ChartIndicatorWidget(
                                title: S.current.khac,
                                color: colorFF9F43,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 6,
                    color: colorEEF3FF,
                  ),
                  GroupChartItemWidget(
                    onChoiceDate: (startDate, endDate) {
                      baoCaoThongKeBCMXHCubit.getSacThaiLineChart(
                        startDate,
                        endDate,
                        widget.topic,
                      );
                    },
                    title: S.current.thong_ke_sac_thai,
                    child: Column(
                      children: [
                        LineChartTheoSacThaiWidget(
                          baoCaoThongKeBCMXHCubit: baoCaoThongKeBCMXHCubit,
                        ),
                        Center(
                          child: Wrap(
                            children: [
                              ChartIndicatorWidget(
                                title: S.current.tich_cuc,
                                color: color28C76F,
                              ),
                              ChartIndicatorWidget(
                                title: S.current.trung_lap,
                                color: color667793,
                              ),
                              ChartIndicatorWidget(
                                title: S.current.tich_cuc,
                                color: colorFF9F43,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
