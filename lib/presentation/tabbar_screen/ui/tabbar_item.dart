import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calendar_work_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_nhiem_vu/ui/tablet/chi_tiet_nhiem_vu_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/chi_tiet_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/mobile/grid_view/danh_sach_bao_cao_dang_girdview.dart';
import 'package:ccvc_mobile/presentation/danh_sach_bao_cao_dang_girdview/ui/tablet/grid_view/danh_sach_bao_cao_dang_girdview.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/mobile/menu_screen.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/tablet/menu_tablet_screen.dart';
import 'package:ccvc_mobile/presentation/widget_manage/ui/tablet/widget_mange_screen_tablet.dart';
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
        // return screenDevice(
        //   mobileScreen: HomeScreenMobile(
        //     key: keyHomeMobile,
        //   ),
        //   tabletScreen: HomeScreenTablet(
        //     key: keyHomeTablet,
        //   ),
        //);
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
            mobileScreen:  NotifyWidget(content: 'Thanh Cong', textButtom: 'dong', image:  ImageAssets.icVideo,),
            tabletScreen: const ChiTietNhiemVuTabletScreen(),
          ),
          backgroundColor: Colors.cyanAccent,
        );
      case TabBarType.menu:
        return screenDevice(
          mobileScreen: const MenuScreen(),
          tabletScreen: Navigator(
            onGenerateRoute: (setting){
              Widget page = MenuTabletScreen();
              if(setting.name == 'a') page =  WidgetManageScreenTablet();
              return MaterialPageRoute(builder: (_) =>  page,);
            },
          )
        );
    }
  }

  TabBarItem getTabBarItem({bool isSelect = false}) {
    switch (this) {
      case TabBarType.home:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect ? ImageAssets.icHomeFocus : ImageAssets.icHomeUnFocus,
            height: 16.0.textScale(),
          ),
          text: S.current.home,
        );
      case TabBarType.report:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect ? ImageAssets.icChartFocus : ImageAssets.icChartUnFocus,
            height: 16.0.textScale(),
          ),
          text: S.current.report,
        );
      case TabBarType.calendarWork:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect
                ? ImageAssets.icCalendarFocus
                : ImageAssets.icCalendarUnFocus,
            height: 16.0.textScale(),
          ),
          text: S.current.calendar_work,
        );
      case TabBarType.internalInteraction:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect
                ? ImageAssets.icMessageFocus
                : ImageAssets.icMessageUnFocus,
            height: 16.0.textScale(),
          ),
          text: S.current.internal_interaction,
        );
      case TabBarType.menu:
        return TabBarItem(
          icon: SvgPicture.asset(
            isSelect ? ImageAssets.icMenuFocus : ImageAssets.icMenuUnFocus,
            height: 16.0.textScale(),
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
