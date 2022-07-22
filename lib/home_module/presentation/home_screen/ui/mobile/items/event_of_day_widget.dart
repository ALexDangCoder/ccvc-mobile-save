import 'package:ccvc_mobile/home_module/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/ket_noi_module/presentation/detail_chung_ket_noi/ui/phone/detail_chung_ket_noi.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/su_kien_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/event_widget.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

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
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _suKienTrongNgayCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SelectKey>(
      stream: _suKienTrongNgayCubit.getSelectkey,
      builder: (context, snapshot){
        final SelectKey key= snapshot.data??SelectKey.HOM_NAY;
        final String title=_suKienTrongNgayCubit.changeTitle(key);
        return ContainerBackgroundWidget(
          minHeight: 350,
          title: title,
          onTapIcon: () {
            HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
          },
          dialogSelect: StreamBuilder<Object>(
              stream: _suKienTrongNgayCubit.selectKeyDialog,
              builder: (context, snapshot) {
                return DialogSettingWidget(
                  type: widget.homeItemType,
                  listSelectKey: <DialogData>[
                    DialogData(
                        onSelect: (value, startDate, endDate) {
                          _suKienTrongNgayCubit.changeSelectKey(value);
                          _suKienTrongNgayCubit.selectDate(
                              selectKey: value,
                              startDate: startDate,
                              endDate: endDate);
                        },
                        initValue: _suKienTrongNgayCubit.selectKeyTime,
                        title: S.current.time,
                        startDate: _suKienTrongNgayCubit.startDate,
                        endDate: _suKienTrongNgayCubit.endDate)
                  ],
                );
              }),
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailChungKetNoi(
                                    id: suKien.id ?? '',
                                  ),
                                ),
                              );
                            },
                            title: suKien.title ?? '',
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
