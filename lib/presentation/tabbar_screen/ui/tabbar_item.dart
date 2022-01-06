import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/ui/tabbar_newspaper.dart';
import 'package:ccvc_mobile/presentation/base_choose_time/ui/base_choose_time_screen.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_tabbar_calender_work.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TabBarType { home, report, calendarWork, internalInteraction, menu }

List<TabBarType> getTabListItem() {
  return [
    TabBarType.home,
    TabBarType.report,
    TabBarType.calendarWork,
    TabBarType.internalInteraction,
    TabBarType.menu,
  ];
}

class TabBarItem {
  Widget icon;
  String text;

  TabBarItem({required this.icon, required this.text});
}

extension TabbarEnum on TabBarType {
  int get index {
    switch (this) {
      case TabBarType.home:
        return 0;
      case TabBarType.report:
        return 1;
      case TabBarType.calendarWork:
        return 2;
      case TabBarType.internalInteraction:
        return 3;
      case TabBarType.menu:
        return 4;

      default:
        return 1;
    }
  }

  Widget getScreen() {
    final a = DateTime.parse('2001-04-25');
    switch (this) {
      case TabBarType.home:
        return const Scaffold(
          backgroundColor: Colors.red,
        );
      case TabBarType.report:
        return  Scaffold(
          backgroundColor: Colors.blue,
          body: BaseChooseTimeScreen(today: a,),
        );
      case TabBarType.calendarWork:
        return const MainTabarCalenderWork();
      case TabBarType.internalInteraction:
        return const Scaffold(
          backgroundColor: Colors.cyanAccent,
        );
      case TabBarType.menu:
        // return const Scaffold(
        //   backgroundColor: Colors.pink,
        // );

        return const TabbarNewspaper();
    }
  }

  TabBarItem getTabBarItem({bool isSelect = false}) {
    switch (this) {
      case TabBarType.home:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect ? ImageAssets.icHomeFocus : ImageAssets.icHomeUnFocus,
            height: 16,
          ),
          text: S.current.home,
        );
      case TabBarType.report:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect ? ImageAssets.icChartFocus : ImageAssets.icChartUnFocus,
            height: 16,
          ),
          text: S.current.report,
        );
      case TabBarType.calendarWork:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect
                ? ImageAssets.icCalendarFocus
                : ImageAssets.icCalendarUnFocus,
            height: 16,
          ),
          text: S.current.calendar_work,
        );
      case TabBarType.internalInteraction:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect
                ? ImageAssets.icMessageFocus
                : ImageAssets.icMessageUnFocus,
            height: 16,
          ),
          text: S.current.internal_interaction,
        );
      case TabBarType.menu:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect ? ImageAssets.icMenuFocus : ImageAssets.icMenuUnFocus,
            height: 16,
          ),
          text: S.current.menu,
        );
    }
  }
}

class TabScreen {
  Widget widget;
  TabBarType type;

  TabScreen({required this.widget, required this.type});
}
