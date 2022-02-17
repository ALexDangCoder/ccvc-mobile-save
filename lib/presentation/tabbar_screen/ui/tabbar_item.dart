import 'dart:developer';
// import 'dart:html';

import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calendar_work_mobile.dart';
import 'package:ccvc_mobile/presentation/calender_work/main_calendar/main_calender_work_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/chi_tiet_lam_viec_tablet.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/phone/detail_meet_calender.dart';
import 'package:ccvc_mobile/presentation/detail_meet_calender/ui/tablet/detail_meet_calender_tab.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/home_screen.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/home_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/mobile/menu_screen.dart';
import 'package:ccvc_mobile/presentation/menu_screen/ui/tablet/menu_tablet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/textformfield/form_group.dart';
import 'package:ccvc_mobile/widgets/textformfield/text_field_validator.dart';
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
        final key = GlobalKey<FormGroupState>();
        return Scaffold(
          backgroundColor: Colors.blue,
          body: FormGroup(
            key: key,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                TextFieldValidator(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "32131";
                    }
                  },
                ),
                TextFieldValidator(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "32131";
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    log("${key.currentState?.checkValidator()}");
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        );
      case TabBarType.calendarWork:
        return screenDevice(
          mobileScreen: const CalenderWorkDayMobile(),
          tabletScreen: const CalenderWorkDayTablet(),
        );
      case TabBarType.internalInteraction:
        return Scaffold(
          body: screenDevice(
            mobileScreen: DetailMeetCalenderScreen(),
            tabletScreen: DetailMeetCalenderTablet(),
          ),
          backgroundColor: Colors.cyanAccent,
        );
      case TabBarType.menu:
        return screenDevice(
          mobileScreen: const MenuScreen(),
          tabletScreen: const MenuTabletScreen(),
        );
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
