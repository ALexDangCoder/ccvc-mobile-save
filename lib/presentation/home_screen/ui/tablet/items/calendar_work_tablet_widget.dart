import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

class CalendarWorkTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const CalendarWorkTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<CalendarWorkTabletWidget> createState() => _CalendarWorkWidgetState();
}

class _CalendarWorkWidgetState extends State<CalendarWorkTabletWidget> {
  final LichLamViecCubit _lamViecCubit = LichLamViecCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lamViecCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _lamViecCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.calendar_work,
      maxHeight: 415,
      minHeight: 415,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _lamViecCubit,
      dialogSelect: StreamBuilder(
        stream: _lamViecCubit.selectKeyDialog,
        builder: (context, _) => DialogSettingWidget(
          listSelectKey: [
            DialogData(
              initValue: _lamViecCubit.selectKeyTime,
              onSelect: (value, startDate, endDate) {
                _lamViecCubit.selectDate(
                    selectKey: value, startDate: startDate, endDate: endDate);
              },
              title: S.current.time,
            )
          ],
          type: widget.homeItemType,
        ),
      ),
      child: Flexible(
        child: LoadingOnly(
          stream: _lamViecCubit.stateStream,
          child: StreamBuilder<List<CalendarMeetingModel>>(
              stream: _lamViecCubit.getListLichLamViec,
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
              }),
        ),
      ),
    );
  }
}
