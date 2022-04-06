

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_cong_viec_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/danh_sach_nhiem_vu_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/nhiem_vu_dashboard_model.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/bloc/nhiem_vu_cubit.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/danh_sach_cong_viec_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/danh_sach_tablet/danh_sach_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/list_danh_sach_cong_viec.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/tablet/widget/list_danh_sach_nhiem_vu.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/widget/bieu_do_nhiem_vu_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class NhiemVuCaNhanTablet extends StatefulWidget {
  final NhiemVuCubit cubit;

  const NhiemVuCaNhanTablet({Key? key, required this.cubit}) : super(key: key);

  @override
  _NhiemVuCaNhanTabletState createState() => _NhiemVuCaNhanTabletState();
}

class _NhiemVuCaNhanTabletState extends State<NhiemVuCaNhanTablet> {
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (
          BuildContext context,
          bool innerBoxIsScrolled,
        ) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: backgroundColorApp,
                child: ChooseTimeScreen(
                  today: DateTime.now(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    color: bgQLVBTablet,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 20.0,
                        right: 30.0,
                        left: 30.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: borderColor.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: BieuDoNhiemVuTablet(
                              title: S.current.nhiem_vu,
                              nhiemVuDashboardModel: nhiemVuDashBoardModel,
                              chartData: widget.cubit.chartDataNhiemVu,
                            ),
                          ),
                          Expanded(
                            child: BieuDoNhiemVuTablet(
                              title: S.current.cong_viec,
                              nhiemVuDashboardModel: nhiemVuDashBoardModel,
                              chartData: widget.cubit.chartDataCongViec,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: bgQLVBTablet,
                    height: 18,
                  ),
                ],
              ),
            ),
          ];
        },
        body: StickyHeader(
          overlapHeaders: true,
          header: Container(
            color: bgQLVBTablet,
            height: 50,
            child: TabBar(
              unselectedLabelStyle: titleAppbar(fontSize: 16),
              unselectedLabelColor: AqiColor,
              labelColor: textDefault,
              labelStyle: titleText(fontSize: 16),
              indicatorColor: textDefault,
              tabs: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(S.current.danh_sach_nhiem_vu),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(S.current.danh_sach_cong_viec),
                ),
              ],
            ),
          ),
          content: TabBarView(
            children: [
              ListDanhSachNhiemVu(
                titleButton: S.current.xem_danh_sach,
                list: [],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DanhSachNhiemVuTablet(),
                    ),
                  );
                },
              ),
              ListDanhSachCongViec(
                titleButton: S.current.xem_danh_sach,
                list: [],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DanhSachCongViecTablet(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
