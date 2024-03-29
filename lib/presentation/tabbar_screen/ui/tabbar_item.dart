import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calendar_work_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/grid_view/danh_sach_bao_cao_dang_girdview.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/tablet/grid_view/danh_sach_bao_cao_dang_girdview.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/mobile/menu_screen.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/tablet/menu_tablet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/notify/notify_widget.dart';
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
    switch (this) {
      case TabBarType.home:
        return screenDevice(
          mobileScreen: HomeScreenMobile(
            key: keyHomeMobile,
          ),
          tabletScreen: HomeScreenTablet(
            key: keyHomeTablet,
          ),
        );
      case TabBarType.report:
        return screenDevice(
          mobileScreen: const DanhSachBaoCaoDangGirdviewMobile(),
          tabletScreen: const DanhSachBaoCaoDangGirdviewTablet(),
        );
      case TabBarType.calendarWork:
        return screenDevice(
          mobileScreen: const CalenderWorkDayMobile(),
          tabletScreen: const CalenderWorkDayTablet(),
        );
      case TabBarType.internalInteraction:
        return Scaffold(
          body: screenDevice(
            mobileScreen: NotifyWidget(
              content: 'Thanh Cong',
              textButtom: 'dong',
              image: ImageAssets.icVideo,
            ),
            tabletScreen: Container(),
          ),
          backgroundColor: Colors.cyanAccent,
        );
      case TabBarType.menu:
        return screenDevice(
            mobileScreen: const MenuScreen(),
            tabletScreen: Navigator(
              onGenerateRoute: (setting) {
                return MaterialPageRoute(
                  builder: (_) => const MenuTabletScreen(),
                );
              },
            ));
    }
  }

  TabBarItem getTabBarItem({bool isSelect = false}) {
    switch (this) {
      case TabBarType.home:
        return TabBarItem(
          icon: SvgPicture.asset(
            ImageAssets.icHomeFocus,
            color: isSelect
                ? AppTheme.getInstance().colorField()
                : AppTheme.getInstance().buttonUnfocus(),
            height: 16.0.textScale(),
          ),
          text: S.current.home,
        );
      case TabBarType.report:
        return TabBarItem(
          icon: SvgPicture.asset(
            ImageAssets.icChartFocus,
            color: isSelect
                ? AppTheme.getInstance().colorField()
                : AppTheme.getInstance().buttonUnfocus(),
            height: 16.0.textScale(),
          ),
          text: S.current.report,
        );
      case TabBarType.calendarWork:
        return TabBarItem(
          icon: SvgPicture.asset(
            ImageAssets.icCalendarFocus,
            height: 16.0.textScale(),
            color: isSelect
                ? AppTheme.getInstance().colorField()
                : AppTheme.getInstance().buttonUnfocus(),
          ),
          text: S.current.calendar_work,
        );
      case TabBarType.internalInteraction:
        return TabBarItem(
          icon: SvgPicture.asset(
            ImageAssets.icMessageFocus,
            height: 16.0.textScale(),
            color: isSelect
                ? AppTheme.getInstance().colorField()
                : AppTheme.getInstance().buttonUnfocus(),
          ),
          text: S.current.internal_interaction,
        );
      case TabBarType.menu:
        return TabBarItem(
          icon: SvgPicture.asset(
            ImageAssets.icMenuFocus,
            height: 16.0.textScale(),
            color: isSelect
                ? AppTheme.getInstance().colorField()
                : AppTheme.getInstance().buttonUnfocus(),
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
