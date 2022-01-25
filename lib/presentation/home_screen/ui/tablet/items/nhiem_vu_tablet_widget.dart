import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';
import 'package:ccvc_mobile/presentation/home_screen/fake_data.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:flutter/material.dart';

class NhiemVuTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const NhiemVuTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<NhiemVuTabletWidget> createState() => _NhiemVuTabletWidgetState();
}

class _NhiemVuTabletWidgetState extends State<NhiemVuTabletWidget> {
  final YKienNguoiDanCubit _danCubit = YKienNguoiDanCubit();
  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      maxHeight: 415,
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
      selectKeyDialog: _danCubit,
      dialogSelect: DialogSettingWidget(
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
            title: S.current.time,
          )
        ],
      ),
      child: Flexible(
        child: ScrollBarWidget(
          children: List.generate(FakeData.documentList.length, (index) {
            final data = FakeData.documentList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ContainerInfoWidget(
                title: data.title,
                status: data.documentStatus.getText(),
                colorStatus: data.documentStatus.getColor(),
                listData: [
                  InfoData(
                    urlIcon: ImageAssets.icSoKyHieu,
                    key: S.current.so_ky_hieu,
                    value: data.kyHieu,
                  ),
                  InfoData(
                    urlIcon: ImageAssets.icAddress,
                    key: S.current.noi_gui,
                    value: data.noiGui,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
