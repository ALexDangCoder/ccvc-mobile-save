import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/fake_data.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
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
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      maxHeight: 858,
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
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: [
          DialogData(
            onSelect: (value, startDate, endDate) {
              _lichHopCubit.selectDate(
                  selectKey: value, startDate: startDate, endDate: endDate);
            },
            title: S.current.time,
          )
        ],
      ),
      child: Flexible(
        child: ScrollBarWidget(
          children: List.generate(FakeData.caledar.length, (index) {
            final data = FakeData.caledar[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ContainerInfoWidget(
                status: data.codeStatus.getText(),
                colorStatus: data.codeStatus.getColor(),
                backGroundStatus: true,
                title: data.title,
                listData: [
                  InfoData(
                    urlIcon: ImageAssets.icTime,
                    key: S.current.time,
                    value: data.time,
                  ),
                  InfoData(
                    urlIcon: ImageAssets.icAddress,
                    key: S.current.dia_diem,
                    value: data.address,
                  ),
                  InfoData(
                    urlIcon: ImageAssets.icPeople,
                    key: S.current.nguoi_chu_tri,
                    value: data.nguoiChuTri,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
