import 'package:ccvc_mobile/home_module/widgets/text/text/no_data_widget.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/tong_hop_nhiem_vu_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/nhiem_vu_widget.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/widgets/text/views/loading_only.dart';

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
    return ContainerBackgroundWidget(
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
              ],
            );
          }),
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LoadingOnly(
          stream: _nhiemVuCubit.stateStream,
          child: StreamBuilder<List<TongHopNhiemVuModel>>(
            stream: _nhiemVuCubit.getTonghopNhiemVu,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <TongHopNhiemVuModel>[];
              if (data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: NodataWidget(),
                );
              }
              return GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                mainAxisSpacing: 17,
                crossAxisSpacing: 17,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  data.length,
                  (index) {
                    final result = data[index];
                    return GestureDetector(
                      onTap: () {
                        // _nhiemVuCubit.clickScreen(result.tongHopNhiemVuModel);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DanhSachNhiemVuMobile(
                        //       ngayBatDau: _nhiemVuCubit.startDate.toString(),
                        //       ngayKetThuc: _nhiemVuCubit.endDate.toString(),
                        //       // ignore: avoid_bool_literals_in_conditional_expressions
                        //       isCheck: _nhiemVuCubit.selectKeyDonVi ==
                        //               SelectKey.DON_VI
                        //           ? false
                        //           : true,
                        //       mangTrangThai: _nhiemVuCubit.mangTrangThai,
                        //       trangThaiHanXuLy: _nhiemVuCubit.trangThaiHanXuLy,
                        //     ),
                        //   ),
                        // );
                      },
                      child: NhiemVuWidget(
                        title: result.tongHopNhiemVuModel.getText(),
                        urlIcon: result.tongHopNhiemVuModel.urlImg(),
                        value: result.value.toString(),
                        type: result.tongHopNhiemVuModel,
                      ),
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
