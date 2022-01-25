import 'dart:developer';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/chart/base_pie_chart.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      title: S.current.situation_of_handling_people,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _yKienCubit,
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: [
          DialogData(
            onSelect: (value,startDate,endDate) {
              _yKienCubit.selectDate(
                  selectKey: value,
                  startDate: startDate,
                  endDate: endDate);
            },
            title: S.current.document,
          )
        ],
      ),
      child: Column(
        children: [
          PieChart(
            chartData: [
              ChartData(S.current.dang_xu_ly, 30, choVaoSoColor),
              ChartData(S.current.da_qua_han, 30, statusCalenderRed),
              ChartData(S.current.da_hoan_thanh, 30, itemWidgetUsing),
            ],
          )
        ],
      ),
    );
  }
}
