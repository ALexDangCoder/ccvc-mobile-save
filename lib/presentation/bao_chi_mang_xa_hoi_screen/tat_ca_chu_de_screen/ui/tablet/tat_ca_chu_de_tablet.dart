import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/hot_new_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/item_infomation_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/item_list_view_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/item_tablet_topic_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TatCaChuDeScreenTablet extends StatefulWidget {
  const TatCaChuDeScreenTablet({Key? key}) : super(key: key);

  @override
  State<TatCaChuDeScreenTablet> createState() => _TatCaChuDeScreenTabletState();
}

class _TatCaChuDeScreenTabletState extends State<TatCaChuDeScreenTablet>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  ChuDeCubit chuDeCubit = ChuDeCubit();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
    chuDeCubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StateStreamLayout(
          textEmpty: S.current.khong_co_du_lieu,
          retry: () {
            chuDeCubit.callApi();
          },
          error: AppException(
            S.current.something_went_wrong,
            S.current.something_went_wrong,
          ),
          stream: chuDeCubit.stateStream,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                ChooseTimeScreen(
                  baseChooseTimeCubit: chooseTimeCubit,
                  today: DateTime.now(),
                  chuDeCubit: chuDeCubit,
                ),
                Container(
                  color: bgCalenderColor,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      StreamBuilder<DashBoardModel>(
                        stream: chuDeCubit.streamDashBoard,
                        builder: (context, snapshot) {
                          final data = snapshot.data?.listItemDashBoard ?? [];
                          return GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 28,
                            crossAxisSpacing: 28,
                            childAspectRatio: 2.3,
                            children: data
                                .map(
                                  (e) => ItemInfomationTablet(
                                    infomationModel: e,
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      StreamBuilder<TuongTacThongKeResponseModel>(
                        stream: chuDeCubit.dataBaoCaoThongKe,
                        builder: (context, snapshot) {
                          final data = snapshot.data ??
                              TuongTacThongKeResponseModel(
                                danhSachTuongtacThongKe: [],
                              );
                          return SizedBox(
                            height: 270,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: data.danhSachTuongtacThongKe.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 28),
                                  child: ItemTableTopicTablet(
                                    chuDeCubit.listTitle[index],
                                    '',
                                    data
                                        .danhSachTuongtacThongKe[index]
                                        .dataTuongTacThongKeModel
                                        .interactionStatistic,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        S.current.tin_noi_bat,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      StreamBuilder<List<ChuDeModel>>(
                        stream: chuDeCubit.listYKienNguoiDan,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final listChuDe = snapshot.data ?? [];
                            final ChuDeModel hotNew = listChuDe.removeAt(0);
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: HotNewsTablet(
                                    hotNew.avartar ?? '',
                                    hotNew.title ?? '',
                                    DateTime.parse(
                                      hotNew.publishedTime ?? '',
                                    ).formatApiSSAM,
                                    hotNew.contents ?? '',
                                    hotNew.url ?? '',
                                  ),
                                ),
                                const SizedBox(
                                  width: 28,
                                  child: Divider(
                                    color: lineColor,
                                    height: 1,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    // controller: _scrollController,
                                    itemCount: listChuDe.length > 3
                                        ? 3
                                        : listChuDe.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ItemListNewsTablet(
                                            listChuDe[index].avartar ?? '',
                                            listChuDe[index].title ?? '',
                                            DateTime.parse(
                                              listChuDe[index].publishedTime ??
                                                  '',
                                            ).formatApiSSAM,
                                            listChuDe[index].url ?? '',
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Divider(
                                              color: lineColor,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
