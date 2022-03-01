import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/chuong_trinh_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/widgets/tai_lieu_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/bieu_quyet_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cong_tac_chuan_bi_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/moi_nguoi_tham_gia_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/phat_bieu_widget_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/thong_tin_cuoc_hop_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/widget/menu_select_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/base_app_bar.dart';
import 'package:ccvc_mobile/widgets/select_only_expands/expand_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class DetailMeetCalenderTablet extends StatefulWidget {
  final String id;
  const DetailMeetCalenderTablet({Key? key, required this.id})
      : super(key: key);

  @override
  State<DetailMeetCalenderTablet> createState() =>
      _DetailMeetCalenderTabletState();
}

class _DetailMeetCalenderTabletState extends State<DetailMeetCalenderTablet> {
  late DetailMeetCalenderCubit cubit;
  final _controller = TabController(vsync: AnimatedListState(), length: 7);

  @override
  void initState() {
    cubit = DetailMeetCalenderCubit();
    cubit.initData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      appBar: BaseAppBar(
        title: S.current.chi_tiet_lich_hop,
        leadingIcon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        actions: [
          MenuSelectWidget(
            listSelect: [
              QData(
                urlImage: ImageAssets.icHuy,
                text: S.current.huy_lich_hop,
                onTap: () {},
              ),
              QData(
                  urlImage: ImageAssets.ic_delete_do,
                  text: S.current.xoa_lich,
                  onTap: () {}),
              QData(
                  urlImage: ImageAssets.icEditBlue,
                  text: S.current.sua_lich,
                  onTap: () {}),
              QData(
                urlImage: ImageAssets.icThuHoi,
                text: S.current.xoa_lich,
                onTap: () {},
              ),
              QData(
                  urlImage: ImageAssets.icPhanCongThuKy,
                  text: S.current.phan_cong_thu_ky,
                  onTap: () {}),
              QData(
                  urlImage: ImageAssets.icTaoBocBang,
                  text: S.current.phan_cong_thu_ky,
                  onTap: () {}),
            ],
          ),
        ],
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
                              child: Container(
                                margin: const EdgeInsets.only(top: 28, left: 28, right: 28),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: backgroundColorApp,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  border: Border.all(color: borderColor.withOpacity(0.5)),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 4),
                                        blurRadius: 10,
                                        color: shadowContainerColor.withOpacity(0.05))
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ThongTinCuocHopWidget(
                                            cubit: cubit,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
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
                  unselectedLabelStyle: textNormalCustom(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  indicatorColor: indicatorColor,
                  unselectedLabelColor: unselectLabelColor,
                  labelColor: indicatorColor,
                  labelStyle: textNormalCustom(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text(
                        S.current.cong_tac_chuan_bi,
                      ),
                    ),
                    Tab(
                      child: Text(
                        S.current.chuong_trinh_hop
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
                    ChuongTrinhHopWidget(),
                    MoiNguoiThamGiaWidgetTablet(),
                    TaiLieuWidget(),
                    PhatBieuWidgetTablet(),
                    BieuQuyetWidgetTablet(),
                    // KetLuanHopWidgetTablet(),
                    // YKienCuocHopWidgetTablet(),
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
