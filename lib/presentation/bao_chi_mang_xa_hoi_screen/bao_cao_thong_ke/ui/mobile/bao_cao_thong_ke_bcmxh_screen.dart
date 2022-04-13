import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/bao_cao_thong_ke/bar_chart_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/bloc/bao_caoThong_ke_bcmxh_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/baocao_chart_item.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/widgets/bar_chart_bcmxh.dart';
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
    baoCaoThongKeBCMXHCubit.getTinTongHop();
    baoCaoThongKeBCMXHCubit.getTongQuanBaoCao();
    baoCaoThongKeBCMXHCubit.clear();
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
                      title: '',
                      child: Column(
                        children: [
                          BarCharWidget(
                            listData: listData ?? [],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BarCharWidget(
                            listData: listStatusData ?? [],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                StreamBuilder<List<List<BarChartModel>>>(
                    stream: baoCaoThongKeBCMXHCubit.listTinTongHop,
                    builder: (context, snapshot) {
                      final listData = snapshot.data ?? [];
                      if (listData.isNotEmpty) {
                        return Column(children: [
                          BarCharWidget(listData: listData[0]),
                          BarCharWidget(listData: listData[1]),
                          BarCharWidget(listData: listData[2]),
                          BarCharWidget(listData: listData[3]),
                        ]);
                      } else {
                        return const NodataWidget();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
