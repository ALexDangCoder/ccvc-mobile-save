import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'detail_meet_calender_tab.dart';

class DetailMeetCalendarTablet extends StatefulWidget {
  const DetailMeetCalendarTablet({Key? key}) : super(key: key);

  @override
  _DetailMeetCalendarTabletState createState() =>
      _DetailMeetCalendarTabletState();
}

class _DetailMeetCalendarTabletState extends State<DetailMeetCalendarTablet> {

  late DetailMeetCalenderCubit cubit;
  var _controller = TabController(vsync: AnimatedListState(), length: 7);
  late ScrollController scrollController;

  @override
  void initState() {
    _controller = TabController(vsync: AnimatedListState(), length: 7);
    cubit = DetailMeetCalenderCubit();
    cubit.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefaultBack(
        S.current.chi_tiet_lich_hop,
      ),
      body: DefaultTabController(
        length: 7,
        child: NestedScrollView(
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            return <Widget>[
              SliverToBoxAdapter(
                child: DetailMeetCalendarInherited(
                  cubit: cubit,
                  child: ExpandGroup(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        size: 12,
                                        color: statusCalenderRed,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        S.current.hop_noi_bo_cong_ty,
                                        style: textNormalCustom(
                                          color: textTitle,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  StreamBuilder<ChiTietLichLamViecModel>(
                                    stream: cubit.chiTietLichLamViecStream,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }

                                      final data = snapshot.data;

                                      return Column(
                                        children: data
                                            ?.dataRow()
                                            .map(
                                              (e) => Container(
                                            margin:
                                            const EdgeInsets.only(top: 24),
                                            child: RowValueWidget(
                                              row: e,
                                              isTablet: false,
                                            ),
                                          ),
                                        )
                                            .toList() ??
                                            [Container()],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // CongTacChuanBiWidget(),
                          // MoiNguoiThamGiaWidget(),
                          // TaiLieuWidget(),
                          // PhatBieuWidget(),
                          // BieuQuyetWidget(),
                          // KetLuanHopWidget(),
                          // YKienCuocHopWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: StickyHeader(
            overlapHeaders: true,
            header:TabBar(
              controller: _controller,
              indicatorColor: indicatorColor,
              unselectedLabelColor: unselectLabelColor,
              labelColor: indicatorColor,
              isScrollable: true,
              tabs: [
                Tab(
                  child: Text(
                    S.current.cong_tac_chuan_bi,
                  ),
                ),
                Tab(
                  child: Text(
                    S.current.thanh_phan_tham_gia,
                  ),
                ),
                Tab(
                  child: Text(
                    S.current.tai_lieu,
                  ),
                ),
                Tab(
                  child: Text(
                    S.current.phat_bieu,
                  ),
                ),
                Tab(
                  child: Text(
                    S.current.bieu_quyet,
                  ),
                ),
                Tab(
                  child: Text(
                    S.current.ket_luan_hop,
                  ),
                ),
                Tab(
                  child: Text(
                    S.current.y_kien_cuop_hop,
                  ),
                ),
              ],
            ) ,
            content: TabBarView(
              controller: _controller,
              children: [

                // CongTacChuanBiWidget(),
                // MoiNguoiThamGiaWidget(),
                // TaiLieuWidget(),
                // PhatBieuWidget(),
                // BieuQuyetWidget(),
                // KetLuanHopWidget(),
                // YKienCuocHopWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
