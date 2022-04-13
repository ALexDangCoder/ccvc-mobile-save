import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_caoThong_ke_bcmxh_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/baocao_chart_item.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/bar_chart_bcmxh.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/indicator_widget.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaoCaoThongKeBCMXHScreen extends StatefulWidget {
  final int topic;

  const BaoCaoThongKeBCMXHScreen({Key? key, required this.topic})
      : super(key: key);

  @override
  State<BaoCaoThongKeBCMXHScreen> createState() =>
      _BaoCaoThongKeBCMXHScreenState();
}

class _BaoCaoThongKeBCMXHScreenState extends State<BaoCaoThongKeBCMXHScreen> {
  BaoCaoThongKeBCMXHCubit baoCaoThongKeBCMXHCubit = BaoCaoThongKeBCMXHCubit();

  @override
  void initState() {
    super.initState();
    // baoCaoThongKeBCMXHCubit.getTongQuanBaoCao();
    // baoCaoThongKeBCMXHCubit.getTinTongHop();
    // baoCaoThongKeBCMXHCubit.clear();
    // baoCaoThongKeBCMXHCubit.getBaoCaoTheoNguon();
    baoCaoThongKeBCMXHCubit.getBaoCaoTheoThoiGian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException(
            S.current.error,
            S.current.error,
          ),
          stream: baoCaoThongKeBCMXHCubit.stateStream,
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<Map<String, List<BarChartModel>>>(
                  stream: baoCaoThongKeBCMXHCubit.mapTongQuan,
                  builder: (context, snapshot) {
                    final data = snapshot.data ?? {};
                    final listData =
                        data[BaoCaoThongKeBCMXHCubit.KEY_TONG_QUAN];
                    final listStatusData =
                        data[BaoCaoThongKeBCMXHCubit.KEY_STATUS_TONG_QUAN];
                    return GroupChartItemWidget(
                      title: S.current.tong_quan,
                      child: Column(
                        children: [
                          BarCharWidget(
                            listData: listData ?? [],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BarCharWidget(
                            color: Colors.green,
                            listData: listStatusData ?? [],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                StreamBuilder<List<List<BarChartModel>>>(
                  stream: baoCaoThongKeBCMXHCubit.listTinTongHop,
                  builder: (context, snapshot) {
                    final listData = snapshot.data ?? [];
                    if (listData.isNotEmpty) {
                      return Column(
                        children: [
                          GroupChartItemWidget(
                            title: S.current.tin_tong_hop,
                            child: BarCharWidget(
                              listData: listData[0],
                              direction: true,
                            ),
                          ),
                          Container(
                            height: 6,
                            color: homeColor,
                          ),
                          GroupChartItemWidget(
                            title: S.current.cac_dia_phuong,
                            child: BarCharWidget(
                              listData: listData[1],
                              direction: true,
                            ),
                          ),
                          Container(
                            height: 6,
                            color: homeColor,
                          ),
                          GroupChartItemWidget(
                            title: S.current.uy_ban_nhan_dan_tinh,
                            child: BarCharWidget(
                              listData: listData[2],
                              direction: true,
                            ),
                          ),
                          Container(
                            height: 6,
                            color: homeColor,
                          ),
                          GroupChartItemWidget(
                            title: S.current.lanh_dao_tinh,
                            child: BarCharWidget(
                              listData: listData[3],
                              direction: true,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const NodataWidget();
                    }
                  },
                ),
                GroupChartItemWidget(
                  title: S.current.thong_ke_theo_nguon_tin,
                  child: StreamBuilder<List<ChartData>>(
                    stream: baoCaoThongKeBCMXHCubit.chartBaoCaoTheoNguon,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      if (data.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PieChart(
                              chartData: data,
                              isSubjectInfo: false,
                            ),
                            const SizedBox(height: 30,),
                            Center(
                              child: Wrap(
                                children: [
                                  ChartIndicatorWidget(
                                    title: S.current.mang_xa_hoi,
                                     color: Colors.blue,
                                  ),
                                  ChartIndicatorWidget(
                                    title: S.current.bao_chi,
                                    color: Colors.green,
                                  ),
                                  ChartIndicatorWidget(
                                    title: S.current.forum,
                                    color: Colors.grey,
                                  ),
                                  ChartIndicatorWidget(
                                    title: S.current.blog,
                                    color: Colors.yellow,
                                  ),
                                  ChartIndicatorWidget(
                                    title: S.current.khac,
                                    color: Colors.purple,
                                  )
                                 ],
                              ),
                            )
                          ],
                        );
                      } else {
                        return const NodataWidget();
                      }
                    },
                  ),
                ),
                Container(
                  height: 6,
                  color: homeColor,
                ),
                GroupChartItemWidget(
                  title: S.current.thong_ke_theo_sac_thai,
                  child: StreamBuilder<List<ChartData>>(
                    stream: baoCaoThongKeBCMXHCubit.chartBaoCaoTheoSacThai,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      if (data.isNotEmpty) {
                        return PieChart(
                          chartData: data,
                        );
                      } else {
                        return const NodataWidget();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
