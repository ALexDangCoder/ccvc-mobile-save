
import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

class MeetingScheduleWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const MeetingScheduleWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<MeetingScheduleWidget> createState() => _MeetingScheduleWidgetState();
}

class _MeetingScheduleWidgetState extends State<MeetingScheduleWidget> {
  final LichHopCubit _lichHopCubit = LichHopCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lichHopCubit.callApi();
  }
  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      spacingTitle: 0,
      minHeight: 350,
      title: S.current.meeting_schedule,
      selectKeyDialog: _lichHopCubit,
      listSelect: const [
        SelectKey.LICH_HOP_CUA_TOI,
        SelectKey.LICH_HOP_DUOC_MOI,
        SelectKey.LICH_HOP_CAN_DUYET,
      ],
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      onChangeKey: (value){
          _lichHopCubit.selectTrangThaiHop(value);
      },
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: [
          DialogData(
            onSelect: (value,startDate,endDate) {
              _lichHopCubit.selectDate(
                  selectKey: value,
                  startDate: startDate,
                  endDate: endDate);
            },
            title: S.current.time,
          )
        ],
      ),
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
            return Column(
              children: List.generate(data.length, (index) {
                final result = data[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ContainerInfoWidget(
                    status: result.codeStatus.getText(),
                    colorStatus: result.codeStatus.getColor(),
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
          }
        ),
      ),
    );
  }
}
