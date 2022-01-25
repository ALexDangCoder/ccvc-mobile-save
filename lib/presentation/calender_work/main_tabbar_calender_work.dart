import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/tab_calender_form/ui/in_calender_form.dart';
import 'package:ccvc_mobile/presentation/calender_work/tab_list_form/ui/in_list_form.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/mobile/drawer_menu.dart';
import 'package:ccvc_mobile/presentation/list_menu/ui/tablet/drawer_menu_tablet.dart';
import 'package:ccvc_mobile/presentation/tao_lich_hop_screen/tao_lich_hop_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/search/base_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainTabarCalenderWork extends StatefulWidget {
  const MainTabarCalenderWork({Key? key}) : super(key: key);

  @override
  _MainTabarCalenderWorkState createState() => _MainTabarCalenderWorkState();
}

class _MainTabarCalenderWorkState extends State<MainTabarCalenderWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorApp,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const TaoLichHopScreen(),
                ),
              );
            },
            icon: SvgPicture.asset(ImageAssets.icAddButtonCalender),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    reverseTransitionDuration:
                        const Duration(milliseconds: 250),
                    transitionDuration: const Duration(milliseconds: 250),
                    pageBuilder: (_, animation, ___) {
                      const begin = Offset(-1.0, 0.0);
                      const end = Offset.zero;
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);
                      return screenDevice(
                          mobileScreen: BaseMenuPhone(offsetAnimation,
                              'Lịch làm việc', ImageAssets.icMenuCalender),
                          tabletScreen: BaseMenuTablet(offsetAnimation,
                              'Lịch làm việc', ImageAssets.icMenuCalender));
                    },
                    opaque: false,
                  ),
                );
              },
              icon: SvgPicture.asset(ImageAssets.icMenuCalender))
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: BaseSearchBar(),
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: backgroundColorApp,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: AppBar(
                    backgroundColor: backgroundColorApp,
                    elevation: 0.0,
                    bottom: TabBar(
                      labelColor: labelColor,
                      unselectedLabelColor: unselectedLabelColor,
                      indicatorColor: indicatorColor,
                      tabs: [
                        Tab(text: S.current.inlistform),
                        Tab(text: S.current.incalenderform),
                      ],
                    ),
                  ),
                ),
                body: const TabBarView(
                  children: [
                    InListForm(),
                    InCalenderForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
