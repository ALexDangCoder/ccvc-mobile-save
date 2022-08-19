import 'package:ccvc_mobile/presentation/canlendar_meeting/ui/tablet/main_calendar_meeting_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/calendar_metting_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/utils/enum_ext.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class MeetingScheduleTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const MeetingScheduleTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<MeetingScheduleTabletWidget> createState() =>
      _MeetingScheduleWidgetState();
}

class _MeetingScheduleWidgetState extends State<MeetingScheduleTabletWidget> {
  final LichHopCubit _lichHopCubit = LichHopCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lichHopCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _lichHopCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      maxHeight: 858,
      minHeight: 415,
      onTapTitle: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainCalendarMeetingTablet(),
          ),
        );
      },
      title: S.current.meeting_schedule,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _lichHopCubit,
      listSelect: const [
        SelectKey.LICH_HOP_CUA_TOI,
        SelectKey.LICH_CHO_XAC_NHAN,
        SelectKey.LICH_HOP_CAN_DUYET,
      ],
      onChangeKey: (value) {
        _lichHopCubit.selectTrangThaiHop(value);
      },
      dialogSelect: StreamBuilder(
          stream: _lichHopCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              type: widget.homeItemType,
              listSelectKey: [
                DialogData(
                    onSelect: (value, startDate, endDate) {
                      _lichHopCubit.selectDate(
                          selectKey: value,
                          startDate: startDate,
                          endDate: endDate);
                    },
                    initValue: _lichHopCubit.selectKeyTime,
                    title: S.current.time,
                    startDate: _lichHopCubit.startDate,
                    endDate: _lichHopCubit.endDate)
              ],
            );
          }),
      child: LoadingOnly(
        stream: _lichHopCubit.stateStream,
        child: StreamBuilder<List<CalendarMeetingModel>>(
            stream: _lichHopCubit.getLichHop,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <CalendarMeetingModel>[];
              if (data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: NodataWidget(),
                );
              }
              return ScrollBarWidget(
                children: List.generate(data.length, (index) {
                  final result = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailMeetCalenderTablet(
                              id: result.id,
                            ),
                          ),
                        );
                      },
                      child: ContainerInfoWidget(
                        status: result.isHopTrucTuyen
                            ? S.current.truc_tuyen
                            : S.current.truc_tiep,
                        colorStatus: result.isHopTrucTuyen
                            ? itemWidgetUsing
                            : textDefault,
                        backGroundStatus: true,
                        status2: result
                                .trangThaiTheoUserEnum(_lichHopCubit.userId)
                                ?.getText() ??
                            '',
                        colorStatus2: result
                            .trangThaiTheoUserEnum(_lichHopCubit.userId)
                            ?.getColor(),
                        backGroundStatus2: true,
                        title: result.title,
                        listData: [
                          InfoData(
                            urlIcon: ImageAssets.icTime,
                            key: S.current.time,
                            value: result.convertTime(),
                          ),
                          InfoData(
                            urlIcon: ImageAssets.icPeople,
                            key: S.current.nguoi_chu_tri,
                            value: result.nguoiChuTri,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),
      ),
    );
  }
}
