import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/fake_data.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/event_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';

import 'package:flutter/material.dart';

class EventOfDayTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const EventOfDayTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _EventOfDayWidgetState createState() => _EventOfDayWidgetState();
}

class _EventOfDayWidgetState extends State<EventOfDayTabletWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.event_of_day,
      minHeight: 415,
      maxHeight: 415,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: <DialogData>[
          DialogData(
            title: S.current.document,
            key: [
              SelectKey.HOM_NAY,
              SelectKey.TUAN_NAY,
              SelectKey.THANG_NAY,
              SelectKey.NAM_NAY
            ],
          )
        ],
      ),
      child: Flexible(
        child: ScrollBarWidget(
          children: List.generate(
            FakeData.suKienTrongNgay.length,
                (index) {
              final data= FakeData.suKienTrongNgay[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child:  EventWidget(
                  onTap: () {},
                  title: data.name,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
