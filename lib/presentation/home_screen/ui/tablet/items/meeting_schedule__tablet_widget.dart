import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

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
      title: S.current.meeting_schedule,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _lichHopCubit,
      listSelect: const [
        SelectKey.LICH_HOP_CUA_TOI,
        SelectKey.LICH_HOP_DUOC_MOI,
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
                      selectKey: value, startDate: startDate, endDate: endDate);
                },
                initValue: _lichHopCubit.selectKeyTime,
                title: S.current.time,
              )
            ],
          );
        }
      ),
      child: Flexible(
        child: LoadingOnly(
          stream: _lichHopCubit.stateStream,
          child: StreamBuilder<List<CalendarMeetingModel>>(
              stream: _lichHopCubit.getLichHop,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <CalendarMeetingModel>[];
                if (data.isEmpty) {
                  return const NodataWidget();
                }
                return ScrollBarWidget(
                  children: List.generate(data.length, (index) {
                    final result = data[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ContainerInfoWidget(
                        status: result.isHopTrucTuyen
                            ? S.current.truc_tuyen
                            : S.current.truc_tiep,
                        colorStatus: result.isHopTrucTuyen
                            ? sideBtnSelected.withOpacity(0.5)
                            : choXuLyColor,
                        backGroundStatus: true,
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
                    );
                  }),
                );
              }),
        ),
      ),
    );
  }
}
