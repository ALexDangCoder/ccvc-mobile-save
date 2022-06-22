import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/config/themes/app_theme.dart';
import 'package:ccvc_mobile/data/exception/app_exception.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_cubit.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/bloc/calendar_work_state.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/choose_time_calendar_widget.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/choose_time_header_widget/controller/chosse_time_calendar_extension.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/main_data_view.dart';
import 'package:ccvc_mobile/presentation/canlendar_refactor/main_calendar/widgets/data_view_widget/menu_widget.dart';
import 'package:ccvc_mobile/presentation/tao_lich_lam_viec_chi_tiet/ui/mobile/tao_lich_lam_viec_chi_tiet_screen.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/size_extension.dart';
import 'package:ccvc_mobile/widgets/appbar/app_bar_with_two_leading.dart';
import 'package:ccvc_mobile/widgets/drawer/drawer_slide.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/views/state_stream_layout.dart';
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
    cubit.refreshApi();
    _handleEventBus();
    super.initState();
  }


  void _handleEventBus() {
    eventBus.on<RefreshCalendar>().listen((event) {
      cubit.refreshApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      textEmpty: S.current.khong_co_du_lieu,
      retry: () {
        cubit.refreshApi();
      },
      error: AppException('', S.current.something_went_wrong),
      stream: cubit.stateStream,
      child: Scaffold(
        appBar: AppBarWithTwoLeading(
          backGroundColorTablet: bgTabletColor,
          widgetTitle: StreamBuilder<String>(
            stream: cubit.titleStream,
            builder: (context, snapshot) {
              final title = snapshot.data ?? S.current.lich_cua_toi;
              return Text(
                title,
                style: titleAppbar(fontSize: 18.0.textScale(space: 6)),
              );
            },
          ),
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
          onRefresh: () async {
            await cubit.refreshApi();
          },
          child: Column(
            children: [
              ChooseTimeCalendarWidget(
                onChange: (startDate, endDate, type, keySearch) {
                  if (cubit.state is CalendarViewState) {
                    cubit.emitCalendar(type: type);
                  } else {
                    cubit.emitList(type: type);
                  }
                },
                controller: cubit.controller,
              ),
              Expanded(child: MainDataView(cubit: cubit)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TaoLichLamViecChiTietScreen(),
              ),
            );
          },
          backgroundColor: AppTheme.getInstance().colorField(),
          child: SvgPicture.asset(ImageAssets.icVectorCalender),
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
