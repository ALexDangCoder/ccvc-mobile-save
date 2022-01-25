import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/fake_data.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:flutter/material.dart';

class NhiemVuWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const NhiemVuWidget({Key? key, required this.homeItemType}) : super(key: key);

  @override
  State<NhiemVuWidget> createState() => _NhiemVuWidgetState();
}

class _NhiemVuWidgetState extends State<NhiemVuWidget> {
  final NhiemVuCubit _nhiemVuCubit = NhiemVuCubit();
  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      title: S.current.nhiem_vu,
      spacingTitle: 0,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      isUnit: true,
      selectKeyDialog: _nhiemVuCubit,
      listSelect: const [
        SelectKey.CHO_PHAN_XU_LY,
        SelectKey.DANG_THUC_HIEN,
        SelectKey.DANH_SACH_CONG_VIEC
      ],
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: <DialogData>[
          DialogData(
            onSelect: (value,_,__) {
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
            onSelect: (value,startDate,endDate) {
              _nhiemVuCubit.selectDate(
                selectKey: value,
                startDate: startDate,
                endDate: endDate,
              );
            },
            title: S.current.time,
          )
        ],
      ),
      child: Column(
        children: List.generate(FakeData.listNhiemView.length, (index) {
          final data = FakeData.listNhiemView[index];
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ContainerInfoWidget(
              title: data.title,
              status: data.codeStatus.getText(),
              colorStatus: data.codeStatus.getColor(),
              listData: [
                InfoData(
                  urlIcon: ImageAssets.icWork,
                  key: S.current.loai_nhiem_vu,
                  value: data.loaiNhiemVu,
                ),
                InfoData(
                  urlIcon: ImageAssets.icCalendar,
                  key: S.current.han_xu_ly,
                  value: data.hanXuLy,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
