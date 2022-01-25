import 'dart:developer';

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
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      title: S.current.people_opinions,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _danCubit,
      spacingTitle: 0,
      listSelect: const [
        SelectKey.CHO_TIEP_NHAN,
        SelectKey.CHO_PHAN_XU_LY,
        SelectKey.CHO_DUYET_XU_LY,
        SelectKey.CHO_DUYET_TIEP_NHAN,
      ],
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: [
          DialogData(
            onSelect: (value,startDate,endDate) {
              _danCubit.selectDate(
                  selectKey: value,
                  startDate: startDate,
                  endDate: endDate);
            },
            title: S.current.time,
          )
        ],
      ),
      child: Column(
        children: List.generate(FakeData.documentList.length, (index) {
          final data = FakeData.documentList[index];
          return Padding(
            padding: const EdgeInsets.only(top: 16),
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
    );
  }
}
