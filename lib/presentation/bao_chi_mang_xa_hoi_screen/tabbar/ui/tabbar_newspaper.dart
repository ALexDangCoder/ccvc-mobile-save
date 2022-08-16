import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/bao_chi_mang_xa_hoi_menu_phone.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/mobile/tat_ca_chu_de_screen.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/ui/mobile/thoi_doi_bai_viet_screen.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tin_tuc_thoi_su_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabbarNewspaper extends StatefulWidget {
  const TabbarNewspaper({Key? key}) : super(key: key);

  @override
  State<TabbarNewspaper> createState() => _TabbarNewspaperState();
}

class _TabbarNewspaperState extends State<TabbarNewspaper>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late final TinTucThoiSuBloc blocTinTuc;

  late TabController _controller;
  late final BaoChiMangXaHoiBloc cubit;
  int topic = 848;

  @override
  void initState() {
    super.initState();
    initData();
    handleEventBus();
  }

  void initData() {
    blocTinTuc = TinTucThoiSuBloc();
    cubit = BaoChiMangXaHoiBloc();
    _controller = TabController(vsync: this, length: 3)..addListener(_onListen);
    cubit.getMenu();
  }

  void handleEventBus() {
    eventBus.on<FireTopic>().listen((event) {
      setState(() {
        topic = event.topic;
      });
    });
  }

  void _onListen() {
    eventBus.on<FireTopic>().listen((event) {
      _controller.animateTo(0, duration: const Duration(milliseconds: 500));
      setState(() {
        topic = event.topic;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: StreamBuilder<String>(
          stream: cubit.titleSubject.stream,
          builder: (context, snapshot) {
            return Text(
              snapshot.data ?? S.current.tong_tin,
              style: titleAppbar(),
            );
          },
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: colorA2AEBD,
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
                  topic: topic,
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
          indicatorColor: AppTheme.getInstance().colorField(),
          unselectedLabelColor: colorA2AEBD,
          labelColor: selectColorTabbar,
          isScrollable: true,
          onTap: (value) {},
          tabs: [
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
            const TatCaChuDeScreen(),
            TheoDoiBaiVietScreen(
              key: UniqueKey(),
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
