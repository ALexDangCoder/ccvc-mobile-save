import 'package:ccvc_mobile/domain/model/home/sinh_nhat_model.dart';
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

class SinhNhatTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const SinhNhatTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _EventOfDayWidgetState createState() => _EventOfDayWidgetState();
}

class _EventOfDayWidgetState extends State<SinhNhatTabletWidget> {
  final SinhNhatCubit sinhNhatCubit = SinhNhatCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sinhNhatCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        sinhNhatCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.birthday,
      maxHeight: 415,
      minHeight: 415,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: sinhNhatCubit,
      dialogSelect: StreamBuilder(
        stream: sinhNhatCubit.selectKeyDialog,
        builder: (context, snapshot) {
          return DialogSettingWidget(
            type: widget.homeItemType,
            listSelectKey: <DialogData>[
              DialogData(
                onSelect: (value, startDate, endDate) {
                  sinhNhatCubit.selectDate(
                      selectKey: value, startDate: startDate, endDate: endDate);
                },
                initValue: sinhNhatCubit.selectKeyTime,
                title: S.current.time,
              )
            ],
          );
        }
      ),
      child: Flexible(
        child: LoadingOnly(
          stream: sinhNhatCubit.stateStream,
          child: StreamBuilder<List<SinhNhatUserModel>>(
              stream: sinhNhatCubit.getSinhNhat,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <SinhNhatUserModel>[];
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
                          title: result.title(),
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
