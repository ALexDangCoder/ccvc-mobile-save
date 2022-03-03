import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tat_ca_chu_de_screen/tat_ca_chu_de_screen.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/bloc/tin_tuc_thoi_su_bloc.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tin_tuc_thoi_su_screen/ui/tin_tuc_thoi_su_screen.dart';
import 'package:ccvc_mobile/widgets/calendar/table_calendar/table_calendar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabbarNewspaper extends StatefulWidget {
  const TabbarNewspaper({Key? key}) : super(key: key);

  @override
  State<TabbarNewspaper> createState() => _TabbarNewspaperState();
}

class _TabbarNewspaperState extends State<TabbarNewspaper> {
  var _controller = TabController(vsync: AnimatedListState(), length: 4);
  @override
  void initState() {
    _controller = TabController(vsync: AnimatedListState(), length: 4);
  }

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(
              Icons.menu_open_rounded,
              color: unselectLabelColor,
            ),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: indicatorColor,
          unselectedLabelColor: unselectLabelColor,
          labelColor: selectColorTabbar,
          isScrollable: true,
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
      body: TabBarView(controller: _controller, children: [
        Text(
          S.current.bao_cao_thong_ke,
        ),
        const TatCaChuDeScreen(),
        Text(S.current.theo_doi_bai_viet),
        TinTucThoiSuScreen(
          tinTucThoiSuBloc: TinTucThoiSuBloc(),
          pContext: context,
        ),
      ],),
    );
  }
}
