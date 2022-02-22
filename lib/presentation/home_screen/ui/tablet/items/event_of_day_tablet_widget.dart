import 'package:ccvc_mobile/domain/model/home/su_kien_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/event_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';

import 'package:flutter/material.dart';

class EventOfDayTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const EventOfDayTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _EventOfDayWidgetState createState() => _EventOfDayWidgetState();
}

class _EventOfDayWidgetState extends State<EventOfDayTabletWidget> {
  final SuKienTrongNgayCubit _suKienTrongNgayCubit = SuKienTrongNgayCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _suKienTrongNgayCubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.event_of_day,
      minHeight: 415,
      maxHeight: 415,
      selectKeyDialog: _suKienTrongNgayCubit,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: <DialogData>[
          DialogData(
            onSelect: (value, startDate, endDate) {
              _suKienTrongNgayCubit.selectDate(
                  selectKey: value, startDate: startDate, endDate: endDate);
            },
            title: S.current.time,
          )
        ],
      ),
      child: Flexible(
        child: LoadingOnly(
          stream: _suKienTrongNgayCubit.stateStream,
          child: StreamBuilder<List<SuKienModel>>(
              stream: _suKienTrongNgayCubit.getSuKien,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <SuKienModel>[];
                if (data.isEmpty) {
                  return Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: const NodataWidget(),
                  );
                }
                return ScrollBarWidget(
                  children: List.generate(
                data.length,
                (index) {
                  final result = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: EventWidget(
                      onTap: () {},
                      title: result.title ?? '',
                    ),
                  );
                },
                  ),
                );
              }),
        ),
      ),
    );
  }
}
