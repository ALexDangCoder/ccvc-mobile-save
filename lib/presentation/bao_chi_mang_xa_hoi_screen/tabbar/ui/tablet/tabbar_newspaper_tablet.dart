import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/bao_cao_thong_ke/ui/tablet/bao_cao_thong_ke_bcmxh_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/menu/tab/menu_bao_chi_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/ui/tablet/tat_ca_chu_de_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/thoi_doi_bai_viet/ui/tablet/theo_doi_bai_viet_tablet.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tablet/tin_tuc_thoi_su_tablet.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabbarNewspaperTablet extends StatefulWidget {
  const TabbarNewspaperTablet({Key? key}) : super(key: key);

  @override
  State<TabbarNewspaperTablet> createState() => _TabbarNewspaperTabletState();
}

class _TabbarNewspaperTabletState extends State<TabbarNewspaperTablet> {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          S.current.tin_tong_hop,
          style: titleAppbar(fontSize: 24),
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
          unselectedLabelColor: unselectLabelColor,
          labelColor: AppTheme.getInstance().colorField(),
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
      body: StateStreamLayout(
        stream: cubit.stateStream,
        retry: () {},
        textEmpty: S.current.khong_co_du_lieu,
        error: AppException(
          S.current.error,
          S.current.error,
        ),
        child: TabBarView(
          controller: _controller,
          children: [
            //  TinRadioScreen(title: 'Tin Radio', tinTucThoiSuBloc: TinTucThoiSuBloc(),),
            StreamBuilder(
              stream: cubit.changeItemMenu,
              builder: (context,snapshot){
                return BaoCaoThongKeBCMXHTabletScreen(
                  key: UniqueKey(),
                  topic: cubit.topic,
                );
              },
            ),
            const TatCaChuDeScreenTablet(),
            StreamBuilder<bool>(
              stream: cubit.changeItemMenu,
              builder: (context, nspshot) {
                return TheoDoiBaiVietTablet(
                  topic: cubit.topic,
                  key: UniqueKey(),
                );
              },
            ),
            TinTucThoiSuScreenTablet(
              tinTucThoiSuBloc: TinTucThoiSuBloc(),
              pContext: context,
            ),
          ],
        ),
      ),
    );
  }
}
