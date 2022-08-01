import 'package:ccvc_mobile/home_module/domain/model/home/y_kien_nguoi_dan_model.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_pakn/ui/phone/chi_tiet_pakn.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/utils/enum_ext.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class PeopleOpinions extends StatefulWidget {
  final WidgetType homeItemType;

  const PeopleOpinions({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<PeopleOpinions> createState() => _PeopleOpinionsState();
}

class _PeopleOpinionsState extends State<PeopleOpinions> {
  final YKienNguoiDanCubit _danCubit = YKienNguoiDanCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _danCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _danCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 250,
      title: S.current.danh_sach_pakn,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _danCubit,
      spacingTitle: 0,
      listSelect: _danCubit.selectKeyPermission,
      onChangeKey: (value) {
        if (_danCubit.selectKeyTrangThai != value) {
          _danCubit.selectTrangThaiApi(value);
        }
      },
      dialogSelect: StreamBuilder(
          stream: _danCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              type: widget.homeItemType,
              listSelectKey: [
                DialogData(
                    onSelect: (value, startDate, endDate) {
                      _danCubit.selectDate(
                        selectKey: value,
                        startDate: startDate,
                        endDate: endDate,
                      );
                    },
                    initValue: _danCubit.selectKeyTime,
                    title: S.current.time,
                    startDate: _danCubit.startDate,
                    endDate: _danCubit.endDate,)
              ],
            );
          }),
      child: LoadingOnly(
        stream: _danCubit.stateStream,
        child: StreamBuilder<List<YKienNguoiDanModel>>(
            stream: _danCubit.getYKien,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <YKienNguoiDanModel>[];
              if (data.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 100),
                  child: NodataWidget(),
                );
              }
              return Column(
                children: List.generate(data.length, (index) {
                  final result = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChiTietPKAN(
                              iD: result.id,
                              taskID: result.taskId,
                            ),
                          ),
                        );
                      },
                      child: ContainerInfoWidget(
                        // colorStatus2: choXuLyColor,
                        title: result.title,
                        status: result.trangThaiXuXy.getText(),
                        colorStatus: result.trangThaiXuXy.getColor(),
                        listData: [
                          InfoData(
                            urlIcon: ImageAssets.icSoKyHieu,
                            key: S.current.so_ky_hieu,
                            value: result.kyHieu,
                          ),
                          InfoData(
                            urlIcon: ImageAssets.icAddress,
                            key: S.current.ten_ca_nhan_to_chuc,
                            value: result.noiGui,
                          ),
                          InfoData(
                            urlIcon: ImageAssets.icTime,
                            key: S.current.han_xu_ly,
                            value: result.hanXuLyCover,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),
      ),
    );
  }
}
