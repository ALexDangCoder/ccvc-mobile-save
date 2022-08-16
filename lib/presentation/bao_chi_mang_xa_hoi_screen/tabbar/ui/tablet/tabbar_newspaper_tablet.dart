import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/tab/menu_bao_chi_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/tat_ca_chu_de_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/ui/tablet/theo_doi_bai_viet_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/tin_tuc_thoi_su_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabbarNewspaperTablet extends StatefulWidget {
  const TabbarNewspaperTablet({Key? key}) : super(key: key);

  @override
  State<TabbarNewspaperTablet> createState() => _TabbarNewspaperTabletState();
}

class _TabbarNewspaperTabletState extends State<TabbarNewspaperTablet>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  BaoChiMangXaHoiBloc cubit = BaoChiMangXaHoiBloc();
  late final TinTucThoiSuBloc blocTinTuc;
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

  void _onListen() {
    eventBus.on<FireTopic>().listen((event) {
      _controller.animateTo(0, duration: const Duration(milliseconds: 500));
      setState(() {
        topic = event.topic;
      });
    });
  }

  void handleEventBus() {
    eventBus.on<FireTopic>().listen((event) {
      setState(() {
        topic = event.topic;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: StreamBuilder<String>(
          stream: cubit.titleSubject.stream,
          builder: (context, snapshot) {
            return Text(
              snapshot.data ?? S.current.tong_tin,
              style: titleAppbar(fontSize: 24),
            );
          },
        ),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 14),
          child: IconButton(
            icon: SvgPicture.asset(ImageAssets.icBack),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MenuBaoChiTablet(
                      topic: topic,
                      onChange: () {
                        cubit.changeScreenMenu();
                      },
                      cubit: cubit,
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(ImageAssets.icMenuLichHopTablet),
            ),
          )
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: AppTheme.getInstance().colorField(),
          unselectedLabelColor: colorA2AEBD,
          labelColor: AppTheme.getInstance().colorField(),
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
      body: TabBarView(
        controller: _controller,
        children: [
          const TatCaChuDeScreenTablet(),
          TheoDoiBaiVietTablet(
            topic: cubit.topic,
            key: UniqueKey(),
          ),
          TinTucThoiSuScreenTablet(
            tinTucThoiSuBloc: blocTinTuc,
            pContext: context,
          ),
        ],
      ),
    );
  }
}
