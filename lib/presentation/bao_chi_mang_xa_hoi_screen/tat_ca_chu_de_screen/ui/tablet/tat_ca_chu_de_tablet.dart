import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/hot_new_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/item_infomation_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/item_tablet_topic_tablet.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/choose_time/ui/choose_time_screen.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'item_list_view_tablet.dart';

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
          _scrollController.position.maxScrollExtent) {
        if (chuDeCubit.page <= chuDeCubit.totalPage) {
          chuDeCubit.page = chuDeCubit.page + 1;
          chuDeCubit.getListTatCaCuDe(
            chuDeCubit.startDate,
            chuDeCubit.endDate,
            pageIndex: chuDeCubit.page,
          );
        }
      }
    });
    chuDeCubit.callApi();
    _handleEventBus();
  }

  void _handleEventBus() {
    eventBus.on<FireTopic>().listen((event) {
      chuDeCubit.callApi();
    });
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
            //physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                spaceH12,
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
                              itemCount: data.danhSachTuongtacThongKe.length,
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? ItemTableTopicTablet(
                                        chuDeCubit.listTitle[index],
                                        '',
                                        data
                                            .danhSachTuongtacThongKe[index]
                                            .dataTuongTacThongKeModel
                                            .interactionStatistic,
                                      )
                                    : const SizedBox.shrink();
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
                        style: textNormalCustom(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: AppTheme.getInstance().titleColor(),
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
                            return ListView.builder(
                              // controller: _scrollController,
                              itemCount: listChuDe.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? HotNewsTablet(
                                        listChuDe[index].avartar ?? '',
                                        listChuDe[index].title ?? '',
                                        DateTime.parse(
                                          listChuDe[index].publishedTime ?? '',
                                        ).formatApiSSAM,
                                        listChuDe[index].contents ?? '',
                                        listChuDe[index].url ?? '',
                                      )
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: ItemListNewsTablet(
                                          listChuDe[index].avartar ?? '',
                                          listChuDe[index].title ?? '',
                                          DateTime.parse(
                                            listChuDe[index].publishedTime ??
                                                '',
                                          ).formatApiSSAM,
                                          listChuDe[index].url ?? '',
                                        ),
                                      );
                              },
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
