import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/mobile/report_screen_mobile.dart';
import 'package:ccvc_mobile/bao_cao_module/presentation/report_screen/ui/tablet/report_screen_tablet.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/home_module/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/mobile/main_canlendar_mobile_refactor.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/tablet/main_canlendar_refactor_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/bloc/menu_cubit.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/mobile/menu_screen.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/tablet/menu_tablet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/utils/provider_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TabBarType { home, report, calendarWork, menu }

List<TabBarType> getTabListItem() {
  return [
    TabBarType.home,
    TabBarType.report,
    TabBarType.calendarWork,
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
      case TabBarType.menu:
        return 3;
      default:
        return 1;
    }
  }

  Widget getScreen() {
    switch (this) {
      case TabBarType.home:
        // return screenDevice(
        //   mobileScreen: HomeScreenMobile(
        //     key: keyHomeMobile,
        //   ),
        //   tabletScreen: HomeScreenTablet(
        //     key: keyHomeTablet,
        //   ),
        // );
      case TabBarType.home:
        return screenDevice(
          mobileScreen: Container(
            key: keyHomeMobile,
          ),
          tabletScreen: Container(
            key: keyHomeTablet,
          ),
        );
      case TabBarType.report:
        return screenDevice(
          mobileScreen: const ReportScreenMobile(),
          tabletScreen: const ReportScreenTablet(),
        );
      case TabBarType.calendarWork:
        return screenDevice(
          mobileScreen: const MainCanlendanMobileRefactor(),
          tabletScreen: const MainCalendarRefactorTablet(),
        );

      case TabBarType.menu:
        final cubit = MenuCubit();
        return ProviderWidget<MenuCubit>(
          cubit: cubit,
          child: screenDevice(
            mobileScreen: const MenuScreen(),
            tabletScreen: Navigator(
              onGenerateRoute: (setting) {
                return MaterialPageRoute(
                  builder: (_) => MenuTabletScreen(
                    menuCubit: cubit,
                  ),
                );
              },
            ),
          ),
        );
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
