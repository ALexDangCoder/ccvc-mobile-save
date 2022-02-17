import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/chi_tiet_lich_lam_viec_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/row_value_widget.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/bloc/detail_meet_calender_cubit.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/detail_meet_calender.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/widget_tablet/bieu_quyet_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/widget_tablet/cong_tac_chuan_bi_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/widget_tablet/ket_luan_hop_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/widget_tablet/nguoi_tham_gia_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/widget_tablet/phat_bieu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/widget_tablet/tai_lieu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/widget/widget_tablet/y_kien_cuoc_hop_widget_tablet.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'Widget_tablet/double_button.dart';

// todo chi tiet van ban
class DetailMeetCalenderTablet extends StatefulWidget {
  @override
  State<DetailMeetCalenderTablet> createState() =>
      _DetailMeetCalenderTabletState();
}

class _DetailMeetCalenderTabletState extends State<DetailMeetCalenderTablet> {
  late DetailMeetCalenderCubit cubit;
  var _controller = TabController(vsync: AnimatedListState(), length: 7);
  late ScrollController scrollController;

  @override
  void initState() {
    _controller = TabController(vsync: AnimatedListState(), length: 7);
    cubit = DetailMeetCalenderCubit();
    scrollController = ScrollController();
    cubit.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgQLVBTablet,
      appBar: AppBarDefaultBack(
        S.current.chi_tiet_lich_hop,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 28, right: 30.0, left: 30.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0)),
            color: backgroundColorApp,
          ),
          child: DefaultTabController(
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
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: SingleChildScrollView(
                              child: StreamBuilder<ChiTietLichLamViecModel>(
                                stream: cubit.chiTietLichLamViecStream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }

                                  final data = snapshot.data;

                                  final listText = data
                                          ?.dataRow()
                                          .where((element) =>
                                              element.type == typeData.text)
                                          .toList() ??
                                      [];

                                  final listText1 = listText.sublist(0, 2);
                                  final listText2 =
                                      listText.sublist(3, listText.length);

                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.circle,
                                            size: 16,
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
                                      const SizedBox(
                                        height: 28,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: listText1
                                                      .map(
                                                        (e) => Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            bottom: 24,
                                                          ),
                                                          child: RowValueWidget(
                                                            row: e,
                                                            isTablet: true,
                                                            isMarinLeft: true,
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                                Column(
                                                  children: listText2
                                                      .map(
                                                        (e) => Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                            bottom: 24,
                                                          ),
                                                          child: RowValueWidget(
                                                            row: e,
                                                            isTablet: true,
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                DoubleButtonWidget(
                                                  onPressed1: () {},
                                                  onPressed2: () {},
                                                ),
                                                const SizedBox(
                                                  height: 28,
                                                ),
                                                Row(
                                                  children: [
                                                    const Expanded(
                                                      flex: 3,
                                                      child: SizedBox(),
                                                    ),
                                                    Expanded(
                                                      flex: 7,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: (data
                                                                    ?.dataRow()
                                                                    .where(
                                                                      (element) =>
                                                                          element
                                                                              .type ==
                                                                          typeData
                                                                              .listperson,
                                                                    )
                                                                    .toList())
                                                                ?.map(
                                                                  (e) =>
                                                                      RowValueWidget(
                                                                    row: e,
                                                                    isTablet:
                                                                        true,
                                                                  ),
                                                                )
                                                                .toList() ??
                                                            [
                                                              Container(),
                                                            ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: StickyHeader(
                overlapHeaders: true,
                header: TabBar(
                  controller: _controller,
                  unselectedLabelStyle: textNormalCustom(fontSize: 16,fontWeight: FontWeight.w400),
                  indicatorColor: indicatorColor,
                  unselectedLabelColor: unselectLabelColor,
                  labelColor: indicatorColor,
                  labelStyle: textNormalCustom(fontSize: 16,fontWeight: FontWeight.w400),
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
                ),
                content: TabBarView(
                  controller: _controller,
                  children: const [
                    CongTacChuanBiWidgetTablet(),
                    MoiNguoiThamGiaWidgetTablet(),
                    TaiLieuWidgetTablet(),
                    PhatBieuWidgetTablet(),
                    BieuQuyetWidgetTablet(),
                    KetLuanHopWidgetTablet(),
                    YKienCuocHopWidgetTablet(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
