import '/home_module/domain/model/home/tong_hop_nhiem_vu_model.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/generated/l10n.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/tong_hop_nhiem_vu_cell.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/nhiem_vu_widget.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';
import 'package:flutter/material.dart';

class SummaryOfTaskTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const SummaryOfTaskTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<SummaryOfTaskTabletWidget> createState() => _SummaryOfTaskWidgetState();
}

class _SummaryOfTaskWidgetState extends State<SummaryOfTaskTabletWidget> {
  late HomeCubit cubit;
  final TongHopNhiemVuCubit _nhiemVuCubit = TongHopNhiemVuCubit();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    cubit = HomeProvider.of(context).homeCubit;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nhiemVuCubit.getDataTongHopNhiemVu();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _nhiemVuCubit.getDataTongHopNhiemVu();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      maxHeight: 858,
      title: S.current.summary_of_tasks,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isUnit: true,
      selectKeyDialog: _nhiemVuCubit,
      dialogSelect: StreamBuilder(
        stream: _nhiemVuCubit.selectKeyDialog,
        builder: (context, snapshot) {
          return DialogSettingWidget(
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
          );
        }
      ),
      padding: EdgeInsets.zero,
      child: Flexible(
        child: LoadingOnly(
          stream: _nhiemVuCubit.stateStream,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: StreamBuilder<List<TongHopNhiemVuModel>>(
              stream: _nhiemVuCubit.getTonghopNhiemVu,
              builder: (context, snapshot) {
                final data = snapshot.data ?? <TongHopNhiemVuModel>[];
                if (data.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TongHopNhiemVuCell(
                      builder: (context, index) {
                        final result = data[index];
                        return NhiemVuWidget(
                          value: result.value.toString(),
                          urlIcon:result.tongHopNhiemVuModel.urlImg(),
                          title: result.tongHopNhiemVuModel.getText(),
                          type: result.tongHopNhiemVuModel,
                        );
                      },
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: NodataWidget(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}