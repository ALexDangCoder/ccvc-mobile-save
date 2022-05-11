import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/mobile/bao_cao_thong_ke_bcmxh_screen.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/bao_chi_mang_xa_hoi_menu_phone.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/mobile/tat_ca_chu_de_screen.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/ui/mobile/thoi_doi_bai_viet_screen.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tin_tuc_thoi_su_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabbarNewspaper extends StatefulWidget {
  const TabbarNewspaper({Key? key}) : super(key: key);

  @override
  State<TabbarNewspaper> createState() => _TabbarNewspaperState();
}

class _TabbarNewspaperState extends State<TabbarNewspaper> with AutomaticKeepAliveClientMixin{
  TinTucThoiSuBloc blocTinTuc = TinTucThoiSuBloc();

  var _controller = TabController(vsync: AnimatedListState(), length: 4);
  BaoChiMangXaHoiBloc cubit = BaoChiMangXaHoiBloc();

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: AnimatedListState(), length: 4);
    cubit.getMenu();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          S.current.tin_tong_hop,
          style: titleAppbar(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: unselectLabelColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
            onPressed: () {
              DrawerSlide.navigatorSlide(
                context: context,
                screen: BaoChiMangXaHoiMenu(
                  onChange: () {
                    cubit.changeScreenMenu();
                  },
                  cubit: cubit,
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: indicatorColor,
          unselectedLabelColor: unselectLabelColor,
          labelColor: selectColorTabbar,
          isScrollable: true,
          onTap: (value) {
            // if (value == 3) {
            //   blocTinTuc.listTinTuc.clear();
            // }
          },
          tabs: [
            Tab(
              child: Text(
                S.current.bao_cao_thong_ke,
              ),
            ),
            Tab(
              child: Text(S.current.tat_ca_chu_de),
            ),
            Tab(
              child: Text(S.current.theo_doi_bai_viet),
            ),
            Tab(
              child: Text(S.current.tin_tuc_thoi_su),
            ),
          ],
        ),
      ),
      body: ProviderWidget<BaoChiMangXaHoiBloc>(
        cubit: cubit,
        child: TabBarView(
          controller: _controller,
          children: [
            BaoCaoThongKeBCMXHScreen(
              key: UniqueKey(),
              topic: cubit.topic,
            ),
            const TatCaChuDeScreen(),
            TheoDoiBaiVietScreen(
              key: UniqueKey(),
              topic: cubit.topic,
            ),
            TinTucThoiSuScreen(
              tinTucThoiSuBloc: blocTinTuc,
              pContext: context,
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
