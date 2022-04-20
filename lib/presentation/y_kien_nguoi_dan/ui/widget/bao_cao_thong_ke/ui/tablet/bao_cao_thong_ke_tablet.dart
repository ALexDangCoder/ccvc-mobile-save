import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/bao_cao_thong_ke/bao_cao_thong_ke_yknd_model.dart';
import 'package:ccvc_mobile/domain/model/y_kien_nguoi_dan/yknd_dash_board_item.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/widget/custom_item_calender_work.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/box_satatus_vb.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/bloc/bao_cao_thong_ke_cubit.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_don_vi_xu_ly.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_linh_vu_xu_ly.dart';
import 'package:ccvc_mobile/presentation/y_kien_nguoi_dan/ui/widget/bao_cao_thong_ke/widgets/chart_so_luong_by_month.dart';
import 'package:ccvc_mobile/tien_ich_module/widget/views/state_stream_layout.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

class BaoCaoThongKeTablet extends StatefulWidget {
  const BaoCaoThongKeTablet({Key? key}) : super(key: key);

  @override
  _BaoCaoThongKeTabletState createState() => _BaoCaoThongKeTabletState();
}

class _BaoCaoThongKeTabletState extends State<BaoCaoThongKeTablet> {
  BaoCaoThongKeYKNDCubit baoCaoCubit = BaoCaoThongKeYKNDCubit();

  @override
  void initState() {
    super.initState();
    baoCaoCubit.baoCaoYKND(
      DateTime.now().toStringWithListFormat,
      DateTime.now().toStringWithListFormat,
    );
    baoCaoCubit.dashBoardBaoCaoYKND(
      DateTime.now().toStringWithListFormat,
      DateTime.now().toStringWithListFormat,
    );
    baoCaoCubit.dashBoardLinhKhacXuLy(DateTime.now().toStringWithListFormat,
        DateTime.now().toStringWithListFormat);
    baoCaoCubit.dashBoardDonViXuLy(DateTime.now().toStringWithListFormat,
      DateTime.now().toStringWithListFormat,);
    baoCaoCubit.dashBoardSoLuongByMonth(DateTime.now().toStringWithListFormat,
      DateTime.now().toStringWithListFormat,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: const BoxDecoration(
          color: bgQLVBTablet,
        ),
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {},
          error: AppException('1', S.current.something_went_wrong),
          stream: baoCaoCubit.stateStream,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      height: 88,
                      child: StreamBuilder<List<YKienNguoiDanDashBroadItem>>(
                        stream: baoCaoCubit.listBaoCaoYKND,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CustomItemCalenderWork(
                                image: data[index].img ?? '',
                                typeName: data[index].typeName ?? '',
                                numberOfCalendars:
                                    data[index].numberOfCalendars ?? 0,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cellColorborder),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<List<ChartData>>(
                              stream: baoCaoCubit.streamDashBoardBaoCaoYKND,
                              builder: (context, snapshot) {
                                final listDataChart = snapshot.data ?? [];
                                return PieChart(
                                  title: S.current.tinh_trang_thuc_hien_yknd,
                                  chartData: listDataChart,
                                  onTap: (int value) {},
                                );
                              },
                            ),
                            Container(height: 20),
                            StreamBuilder<DashBroadItemYKNDModel>(
                              stream: baoCaoCubit.listChartDashBoard,
                              builder: (context, snapshot) {
                                final data =
                                    snapshot.data ?? DashBroadItemYKNDModel();
                                return Row(
                                  children: [
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Expanded(
                                      child: BoxStatusVanBan(
                                        value: data.trongHan ?? 0,
                                        onTap: () {},
                                        color: numberOfCalenders,
                                        statusName: S.current.trong_han,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: BoxStatusVanBan(
                                        value: data.quaHan ?? 0,
                                        onTap: () {},
                                        color: statusCalenderRed,
                                        statusName: S.current.den_han,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cellColorborder),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textviewTitle(S.current.linh_vuc_xu_ly),
                            ChartLinhVucXuLyWidget(
                              cubit: baoCaoCubit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cellColorborder),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textviewTitle(S.current.so_luong_yknd),
                            ChartSoLuongByMonthWidget(cubit: baoCaoCubit),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24,),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: cellColorborder),
                          boxShadow: [
                            BoxShadow(
                              color: shadowContainerColor.withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textviewTitle(S.current.don_vi_xu_ly),
                            ChartDonViXuLyWidget(
                              cubit: baoCaoCubit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textviewTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(
        title,
        style: textNormalCustom(
          color: textTitle,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
