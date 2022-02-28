
import 'package:ccvc_mobile/domain/model/home/sinh_nhat_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/event_widget.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

class SinhNhatWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const SinhNhatWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  _EventOfDayWidgetState createState() => _EventOfDayWidgetState();
}

class _EventOfDayWidgetState extends State<SinhNhatWidget> {
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
    return ContainerBackgroundWidget(
      minHeight: 350,
      title: S.current.birthday,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: sinhNhatCubit,
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: <DialogData>[
          DialogData(
            onSelect: (value,startDate,endDate) {
              sinhNhatCubit.selectDate(
                selectKey: value,
                startDate: startDate,
                endDate: endDate,
              );
            },
            title: S.current.time,
          )
        ],
      ),
      child: LoadingOnly(
        stream: sinhNhatCubit.stateStream,
        child: StreamBuilder<List<SinhNhatUserModel>>(
          stream: sinhNhatCubit.getSinhNhat,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <SinhNhatUserModel>[];
            if (data.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: NodataWidget(),
              );
            }
            return Column(
              children: List.generate(
               data.length,
                (index) {
                  final result = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: EventWidget(
                      onTap: () {},
                      title:result.title(),
                    ),
                  );
                },
              ),
            );
          }
        ),
      ),
    );
  }

}
