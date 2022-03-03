import 'package:ccvc_mobile/domain/model/home/calendar_metting_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

class NhiemVuTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const NhiemVuTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<NhiemVuTabletWidget> createState() => _NhiemVuTabletWidgetState();
}

class _NhiemVuTabletWidgetState extends State<NhiemVuTabletWidget> {
  final NhiemVuCubit _nhiemVuCubit = NhiemVuCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nhiemVuCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _nhiemVuCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      maxHeight: 415,
      minHeight: 415,
      title: S.current.nhiem_vu,
      isUnit: true,
      listSelect: const [
        SelectKey.CHO_PHAN_XU_LY,
        SelectKey.DANG_THUC_HIEN,
        SelectKey.DANH_SACH_CONG_VIEC
      ],
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _nhiemVuCubit,
      onChangeKey: (value) {
        if (value != _nhiemVuCubit.selectTrangThai) {
          _nhiemVuCubit.selectTrangThaiNhiemVu(value);
        }
      },
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
                initValue: _nhiemVuCubit.selectKeyTime,
                title: S.current.time,
              )
            ],
          );
        }
      ),
      child: Flexible(
        child: LoadingOnly(
          stream: _nhiemVuCubit.stateStream,
          child: StreamBuilder<List<CalendarMeetingModel>>(
            stream: _nhiemVuCubit.getNhiemVu,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <CalendarMeetingModel>[];
              if (data.isEmpty) {
                return const NodataWidget();
              }
              return ScrollBarWidget(
                children: List.generate(data.length, (index) {
                  final result = data[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ContainerInfoWidget(
                      title: result.title,
                      status: result.codeStatus.getText(),
                      colorStatus: result.codeStatus.getColor(),
                      listData: [
                        InfoData(
                          urlIcon: ImageAssets.icWork,
                          key: _nhiemVuCubit.isCongViec
                              ? S.current.nguoi_giao_viec
                              : S.current.loai_nhiem_vu,
                          value: result.loaiNhiemVu,
                        ),
                        InfoData(
                          urlIcon: ImageAssets.icCalendar,
                          key: S.current.han_xu_ly,
                          value: result.hanXuLy,
                        ),
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
