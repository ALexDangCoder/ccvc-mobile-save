import 'dart:developer';

import 'package:ccvc_mobile/domain/model/home/tong_hop_nhiem_vu_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/nhiem_vu_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';

import 'package:flutter/material.dart';

class SummaryOfTaskWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const SummaryOfTaskWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<SummaryOfTaskWidget> createState() => _SummaryOfTaskWidgetState();
}

class _SummaryOfTaskWidgetState extends State<SummaryOfTaskWidget> {
  late HomeCubit cubit;
  final TongHopNhiemVuCubit _nhiemVuCubit = TongHopNhiemVuCubit();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
    _nhiemVuCubit.getDataTongHopNhiemVu();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      title: S.current.summary_of_tasks,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isUnit: true,
      selectKeyDialog: _nhiemVuCubit,
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: [
          DialogData(
            onSelect: (value, _, __) {
              _nhiemVuCubit.selectDonVi(
                selectKey: value,
              );
            },
            title: S.current.nhiem_vu,
            initValue: _nhiemVuCubit.selectKeyDonVi,
            key: [
              SelectKey.CA_NHAN,
              SelectKey.DON_VI,
            ],
          ),
          DialogData(
            onSelect: (value, startDate, endDate) {
              _nhiemVuCubit.selectDate(
                selectKey: value,
                startDate: startDate,
                endDate: endDate,
              );
            },
            startDate: _nhiemVuCubit.startDate,
            endDate: _nhiemVuCubit.endDate,
            title: S.current.time,
            initValue: _nhiemVuCubit.selectKeyTime,
          )
        ],
      ),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LoadingOnly(
          stream: _nhiemVuCubit.stateStream,
          child: StreamBuilder<List<TongHopNhiemVuModel>>(
            stream: _nhiemVuCubit.getTonghopNhiemVu,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <TongHopNhiemVuModel>[];
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 17,
                crossAxisSpacing: 17,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  data.length,
                  (index) {
                    final result = data[index];
                    return NhiemVuWidget(
                      title: result.tongHopNhiemVuModel.getText(),
                      urlIcon: result.tongHopNhiemVuModel.urlImg(),
                      value: result.value.toString(),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
