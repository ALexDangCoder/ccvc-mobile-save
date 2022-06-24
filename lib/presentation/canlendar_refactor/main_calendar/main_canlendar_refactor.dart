import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_calendar_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/controller/chosse_time_calendar_extension.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/main_data_view.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainCanlendanRefactor extends StatefulWidget {
  const MainCanlendanRefactor({Key? key}) : super(key: key);

  @override
  _MainCanlendanRefactorState createState() => _MainCanlendanRefactorState();
}

class _MainCanlendanRefactorState extends State<MainCanlendanRefactor> {
  final CalendarWorkCubit cubit = CalendarWorkCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithTwoLeading(
        backGroundColorTablet: bgTabletColor,
        title: S.current.lich_cua_toi,
        leadingIcon: Row(
          children: [
            cubit.controller.getIcon(),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMenu();
            },
            icon: SvgPicture.asset(ImageAssets.icMenuCalender),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Column(
          children: [
            StreamBuilder<List<DateTime>>(
                stream: cubit.listNgayCoLich,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? <DateTime>[];
                  return ChooseTimeCalendarWidget(
                    calendarDays: data,
                    onChange: (startDate, endDate, type, keySearch) {
                      if (cubit.state is CalendarViewState) {
                        cubit.emitCalendar(type: type);
                      } else {
                        cubit.emitList(type: type);
                      }

                      cubit.callApiByNewFilter(
                          startDate: startDate,
                          endDate: endDate,
                          keySearch: keySearch);
                    },

                    controller: cubit.controller,
                    onChangeYear: (startDate, endDate, keySearch) {
                      cubit.dayHaveEvent(startDate, endDate, keySearch);
                    },
                  );
                }),
            Expanded(child: MainDataView(cubit: cubit)),
          ],
        ),
      ),
    );
  }

  void showMenu() {
    DrawerSlide.navigatorSlide(
      context: context,
      screen: MenuWidget(cubit: cubit),
    );
  }
}
