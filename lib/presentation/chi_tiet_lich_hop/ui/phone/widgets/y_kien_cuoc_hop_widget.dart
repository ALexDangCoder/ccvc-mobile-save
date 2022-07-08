import 'package:ccvc_mobile/bao_cao_module/widget/dropdown/custom_drop_down.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/list_phien_hop.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/y_kien_cuoc_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/y_kien_cuoc_hop_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/comment_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/icon_with_title_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/them_y_kien__widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class YKienCuocHopWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const YKienCuocHopWidget({Key? key, required this.cubit}) : super(key: key);

  @override
  _YKienCuocHopWidgetState createState() => _YKienCuocHopWidgetState();
}

class _YKienCuocHopWidgetState extends State<YKienCuocHopWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    if (!isMobile()) {
      widget.cubit.callApiYkienCuocHop();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (value) {
          if (value && !widget.cubit.listYKienCuocHop.hasValue) {
            widget.cubit.callApiYkienCuocHop();
            try {
              final String phienHopID =
                  widget.cubit.danhSachChuongTrinhHop.valueOrNull?.first.id ??
                      '';
              if (phienHopID.isNotEmpty) {
                widget.cubit.getDanhSachYKien(
                  id: widget.cubit.idCuocHop,
                  phienHopId: phienHopID,
                );
              }
            } catch (e) {
              //
            }
          }
        },
        title: S.current.y_kien_cuop_hop,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: themYKienWidgetForPhoneAndTab(),
        ),
      ),
      tabletScreen: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: SingleChildScrollView(
          child: themYKienWidgetForPhoneAndTab(),
        ),
      ),
    );
  }

  Widget themYKienWidgetForPhoneAndTab() {
    return Column(
      children: [
        IconWithTiltleWidget(
          icon: ImageAssets.Comment_ic,
          title: S.current.them_y_kien,
          onPress: () {
            showBottomSheetCustom(
              context,
              title: S.current.y_kien,
              child: ThemYKienWidget(
                cubit: widget.cubit,
                id: widget.cubit.idCuocHop,
              ),
            );
          },
        ),
        DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: color667793.withOpacity(0.3),
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Align(
                  child: TabBar(
                    onTap: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    controller: _tabController,
                    unselectedLabelColor: color667793,
                    labelColor: AppTheme.getInstance().colorField(),
                    unselectedLabelStyle: textNormal(
                      color667793,
                      14,
                    ),
                    labelStyle: textNormal(
                      color667793,
                      14,
                    ).copyWith(fontWeight: FontWeight.w700),
                    tabs: [
                      Expanded(child: Text(S.current.cuoc_hop)),
                      Expanded(child: Text(S.current.phien_hop)),
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppTheme.getInstance().colorField(),
                    labelPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              ExpandablePageView(
                controller: _pageController,
                onPageChanged: (value) {
                  _tabController.animateTo(
                    value,
                  );
                },
                children: [
                  StreamBuilder<List<YkienCuocHopModel>>(
                    stream: widget.cubit.listYKienCuocHop.stream,
                    builder: (context, snapshot) {
                      final data = snapshot.data ?? [];
                      if (data.isEmpty) {
                        return const NodataWidget(
                          height: 200,
                        );
                      }
                      return ListView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CommentWidget(
                            yKienCuocHop: data[index],
                            cubit: widget.cubit,
                            id: widget.cubit.idCuocHop,
                          );
                        },
                      );
                    },
                  ),
                  Column(
                    children: [
                      spaceH16,
                      StreamBuilder<List<ListPhienHopModel>>(
                        stream: widget.cubit.danhSachChuongTrinhHop.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          final listCuocHop =
                              data.map((e) => e.tieuDe ?? '').toSet().toList();
                          return CustomDropDown(
                            value: widget.cubit.tenPhienHop.isNotEmpty
                                ? widget.cubit.tenPhienHop
                                : listCuocHop.isNotEmpty
                                    ? listCuocHop.first
                                    : '',
                            items: listCuocHop,
                            onSelectItem: (value) {
                              widget.cubit.getDanhSachYKien(
                                id: widget.cubit.idCuocHop,
                                phienHopId: data[value].id ?? '',
                              );
                            },
                          );
                        },
                      ),
                      StreamBuilder<List<YkienCuocHopModel>>(
                        stream: widget.cubit.listYKienPhienHop.stream,
                        builder: (context, snapshot) {
                          final data = snapshot.data ?? [];
                          if (data.isEmpty) {
                            return const NodataWidget(
                              height: 200,
                            );
                          }
                          return ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                yKienCuocHop: data[index],
                                cubit: widget.cubit,
                                id: widget.cubit.idCuocHop,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
