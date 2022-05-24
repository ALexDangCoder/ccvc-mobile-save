import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/bao_cao_thong_ke.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/dashboard_item.dart';
import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/bloc/chu_de_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/mobile/hot_new.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/mobile/item_infomation.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/mobile/item_list_new.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/mobile/item_table_topic.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/mobile/sreach_sheet_btn.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class TatCaChuDeScreen extends StatefulWidget {
  const TatCaChuDeScreen({Key? key}) : super(key: key);

  @override
  State<TatCaChuDeScreen> createState() => _TatCaChuDeScreenState();
}

class _TatCaChuDeScreenState extends State<TatCaChuDeScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  late ChuDeCubit chuDeCubit;
  String defaultTime = ChuDeCubit.HOM_NAY;

  @override
  void initState() {
    super.initState();
    chuDeCubit = ChuDeCubit();
    chuDeCubit.callApi();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (chuDeCubit.pageIndex <= chuDeCubit.totalPage) {
          chuDeCubit.pageIndex = chuDeCubit.pageIndex + 1;
          chuDeCubit.getListTatCaCuDe(chuDeCubit.startDate, chuDeCubit.endDate);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: CustomDropDown(
                      paddingTop: 0,
                      paddingLeft: 16,
                      value: defaultTime,
                      items: chuDeCubit.dropDownItem,
                      onSelectItem: (index) {
                        chuDeCubit.getOptionDate(
                          chuDeCubit.dropDownItem[index],
                        );
                        chuDeCubit.getDashboard(
                          chuDeCubit.startDate,
                          chuDeCubit.endDate,
                          isShow: true,
                        );
                        chuDeCubit.getListTatCaCuDe(
                          chuDeCubit.startDate,
                          chuDeCubit.endDate,
                          isShow: true,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance()
                            .colorField()
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: SvgPicture.asset(
                            ImageAssets.ic_box_serach,
                            fit: BoxFit.cover,
                            color: AppTheme.getInstance().colorField(),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showBottomSheetCustom(
                        context,
                        child: SearchBanTinBtnSheet(
                          cubit: chuDeCubit,
                        ),
                        title: S.current.tim_kiem,
                      );
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: StateStreamLayout(
                textEmpty: S.current.khong_co_du_lieu,
                retry: () {
                  chuDeCubit.callApi();
                },
                error: AppException(
                    S.current.error, S.current.something_went_wrong),
                stream: chuDeCubit.stateStream,
                child: RefreshIndicator(
                  onRefresh: () async {
                    chuDeCubit.pageIndex = 1;
                    chuDeCubit.totalPage = 1;
                    setState(() {
                      defaultTime = ChuDeCubit.HOM_NAY;
                    });
                    await chuDeCubit.callApi();
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: StreamBuilder<DashBoardModel>(
                            stream: chuDeCubit.streamDashBoard,
                            builder: (context, snapshot) {
                              final data =
                                  snapshot.data?.listItemDashBoard ?? [];
                              return GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                childAspectRatio: 2.3,
                                children: data
                                    .map(
                                      (e) => ItemInfomation(
                                        infomationModel: e,
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                        ),
                        StreamBuilder<TuongTacThongKeResponseModel>(
                          stream: chuDeCubit.dataBaoCaoThongKe,
                          builder: (context, snapshot) {
                            final data = snapshot.data ??
                                TuongTacThongKeResponseModel(
                                  danhSachTuongtacThongKe: [],
                                );
                            return SizedBox(
                              height: 240,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: data.danhSachTuongtacThongKe.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: index == 0
                                        ? const EdgeInsets.only(
                                            left: 16,
                                          )
                                        : EdgeInsets.zero,
                                    child: ItemTableTopic(
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
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: StreamBuilder<List<ChuDeModel>>(
                            stream: chuDeCubit.listYKienNguoiDan,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final listChuDe = snapshot.data ?? [];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.current.tin_noi_bat,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: titleColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    HotNews(
                                      chuDeCubit.hotNewData.avartar ?? '',
                                      chuDeCubit.hotNewData.title ?? '',
                                      DateTime.parse(
                                        chuDeCubit.hotNewData.publishedTime ??
                                            '',
                                      ).formatApiSSAM,
                                      chuDeCubit.hotNewData.contents ?? '',
                                      chuDeCubit.hotNewData.url ?? '',
                                    ),
                                    const SizedBox(
                                      height: 16,
                                      child: Divider(
                                        color: lineColor,
                                        height: 1,
                                      ),
                                    ),
                                    ListView.builder(
                                      itemCount:
                                          chuDeCubit.listChuDeLoadMore.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        if (index ==
                                            chuDeCubit
                                                    .listChuDeLoadMore.length -
                                                1) {
                                          if (chuDeCubit.listChuDeLoadMore
                                                      .length +
                                                  1 ==
                                              chuDeCubit.totalItem) {
                                            return const SizedBox();
                                          } else {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: AppTheme.getInstance()
                                                    .primaryColor(),
                                              ),
                                            );
                                          }
                                        }
                                        return Column(
                                          children: [
                                            ItemListNews(
                                              listChuDe[index].avartar ?? '',
                                              listChuDe[index].title ?? '',
                                              DateTime.parse(
                                                listChuDe[index]
                                                        .publishedTime ??
                                                    '',
                                              ).formatApiSSAM,
                                              listChuDe[index].url ?? '',
                                            ),
                                            const SizedBox(
                                              height: 16,
                                              child: Divider(
                                                color: lineColor,
                                                height: 1,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
