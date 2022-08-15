import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/choose_time/bloc/choose_time_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/bloc/qlvb_cubit.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/menu/van_ban_menu_mobile.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/document_in_page_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/tablet/widgets/document_out_page_tablet.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/search_bar.dart';
import 'package:ccvc_mobile/presentation/quan_li_van_ban/ui/widgets/tab_bar.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_default_back.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/filter_date_time/filter_date_time_widget.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QLVBScreenTablet extends StatefulWidget {
  const QLVBScreenTablet({Key? key}) : super(key: key);

  @override
  _QLVBScreenTabletState createState() => _QLVBScreenTabletState();
}

class _QLVBScreenTabletState extends State<QLVBScreenTablet>
    with SingleTickerProviderStateMixin {
  QLVBCCubit qlvbCubit = QLVBCCubit();
  ChooseTimeCubit chooseTimeCubit = ChooseTimeCubit();
  late TabController _tabController;
  late ScrollController scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    super.initState();
    qlvbCubit.callAPi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTabletColor,
      // appBar: AppBarDefaultBack(
      //   S.current.thong_tin_chung,
      //
      // ),
      appBar: AppBarWithTwoLeading(
        backGroundColorTablet: bgWidgets,
        leadingIcon: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        title: S.current.thong_tin_chung,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                DrawerSlide.navigatorSlide(
                  context: context,
                  screen: VanBanMenuMobile(
                    cubit: qlvbCubit,
                  ),
                );
              },
              child: SvgPicture.asset(ImageAssets.icMenuCalender),
            ),
          ),
        ],
      ),
      body: StateStreamLayout(
        textEmpty: S.current.khong_co_du_lieu,
        retry: () {},
        error: AppException('1', ''),
        stream: qlvbCubit.stateStream,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: bgDropDown))),
              child: Row(

                children: [
                  FilterDateTimeWidget(
                    context: context,
                    isMobile: false,
                    initStartDate: DateTime.parse(qlvbCubit.startDate),
                    onChooseDateFilter: (startDate, endDate) {
                      qlvbCubit.startDate = startDate.formatApi;
                      qlvbCubit.endDate = endDate.formatApi;
                      qlvbCubit.callAPi(initTime: false);
                      eventBus.fire(RefreshList());
                    },
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: SearchBarDocumentManagement(
                      qlvbCubit: qlvbCubit,
                      isTablet: true,
                      initKeyWord: qlvbCubit.keySearch,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: tabBar(_tabController),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  DocumentInPageTablet(
                    qlvbCubit: qlvbCubit,
                  ),
                  DocumentOutPageTablet(
                    qlvbCubit: qlvbCubit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
