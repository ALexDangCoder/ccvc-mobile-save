import 'package:ccvc_mobile/presentation/danh_sach_y_kien_nd/ui/mobile/danh_sach_yknd_screen.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/tinh_hinh_y_kien_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/widgets/chart/base_pie_chart.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class SituationOfHandlingPeopleWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const SituationOfHandlingPeopleWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<SituationOfHandlingPeopleWidget> createState() =>
      _SituationOfHandlingPeopleWidgetState();
}

class _SituationOfHandlingPeopleWidgetState
    extends State<SituationOfHandlingPeopleWidget> {
  final TinhHinhXuLyYKienCubit _yKienCubit = TinhHinhXuLyYKienCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _yKienCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _yKienCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 420,
      title: S.current.situation_of_handling_people,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _yKienCubit,
      dialogSelect: StreamBuilder(
          stream: _yKienCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              type: widget.homeItemType,
              listSelectKey: <DialogData>[
                DialogData(
                  onSelect: (value, startDate, endDate) {
                    _yKienCubit.selectDate(
                        selectKey: value,
                        startDate: startDate,
                        endDate: endDate);
                  },
                  initValue: _yKienCubit.selectKeyTime,
                  title: S.current.time,
                )
              ],
            );
          }),
      child: LoadingOnly(
        stream: _yKienCubit.stateStream,
        child: StreamBuilder<List<TinhHinhYKienModel>>(
            stream: _yKienCubit.getTinhHinhXuLy,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <TinhHinhYKienModel>[];
              if (data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: NodataWidget(),
                );
              }
              return PieChart(
                chartData: List.generate(
                  data.length,
                  (index) {
                    final result = data[index];
                    final color = TinhHinhYKienModel.listColor[index];
                    return ChartData(
                      result.status,
                      result.soLuong.toDouble(),
                      color,
                    );
                  },
                ),
                onTap: (value, key) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DanhSachYKND(
                        endDate: _yKienCubit.endDate.toString(),
                        startDate: _yKienCubit.startDate.toString(),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
