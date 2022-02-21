import 'package:ccvc_mobile/domain/model/home/su_kien_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/fake_data.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/event_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

class EventOfDayWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const EventOfDayWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _EventOfDayWidgetState createState() => _EventOfDayWidgetState();
}

class _EventOfDayWidgetState extends State<EventOfDayWidget> {
  final SuKienTrongNgayCubit _suKienTrongNgayCubit = SuKienTrongNgayCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _suKienTrongNgayCubit.callApi();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 350,
      title: S.current.su_kien,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: [
          DialogData(
            onSelect: (value, startDate, endDate) {
              _suKienTrongNgayCubit.selectDate(
                selectKey: value,
                startDate: startDate,
                endDate: endDate,
              );
            },
            title: S.current.time,
          )
        ],
      ),
      selectKeyDialog: _suKienTrongNgayCubit,
      child: LoadingOnly(
        stream: _suKienTrongNgayCubit.stateStream,
        child: StreamBuilder<List<SuKienModel>>(
            stream: _suKienTrongNgayCubit.getSuKien,
            builder: (context, snapshot) {
              final result = snapshot.data ?? <SuKienModel>[];
              if (result.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: NodataWidget(),
                );
              }
              return Column(
                children: List.generate(
                  result.length,
                  (index) {
                    final suKien = result[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: EventWidget(
                        onTap: () {},
                        title: suKien.title ?? '',
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
