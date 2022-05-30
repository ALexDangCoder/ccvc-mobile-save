import 'package:ccvc_mobile/home_module/presentation/thiep_chuc_sinh_nhat_screen.dart/tablet/thiep_chuc_sinh_nhat_tablet_screen.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/sinh_nhat_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/event_widget.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

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
      padding: EdgeInsets.zero,
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
                        selectKey: value,
                        startDate: startDate,
                        endDate: endDate);
                  },
                  initValue: sinhNhatCubit.selectKeyTime,
                  title: S.current.time,
                  startDate: sinhNhatCubit.startDate,
                  endDate: sinhNhatCubit.endDate,
                )
              ],
            );
          }),
      child: LoadingOnly(
        stream: sinhNhatCubit.stateStream,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: StreamBuilder<List<SinhNhatUserModel>>(
                stream: sinhNhatCubit.getSinhNhat,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? <SinhNhatUserModel>[];
                  if (data.isEmpty) {
                    return Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 100),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ThiepChucMungTabletScreen(
                                    sinhNhatUserModel: result,
                                  ),
                                ),
                              ).then((value) {
                                if (value != null) {
                                  MessageConfig.show(title: value);
                                }
                              });
                            },
                            title: result.title(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
