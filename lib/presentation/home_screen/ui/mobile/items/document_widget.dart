import 'dart:developer';

import 'package:ccvc_mobile/domain/model/home/document_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/home_screen/bloc/home_cubit.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/home_provider.dart';

import 'package:ccvc_mobile/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/container_info_widget.dart';
import 'package:ccvc_mobile/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/enum_ext.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:ccvc_mobile/widgets/views/loading_only.dart';
import 'package:flutter/material.dart';

class DocumentWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const DocumentWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<DocumentWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  final VanBanCubit _vanBanCubit = VanBanCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vanBanCubit.selectTrangThaiVanBan(SelectKey.CHO_VAO_SO);
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundWidget(
      minHeight: 340,
      title: S.current.document,
      spacingTitle: 0,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      onChangeKey: (value){
        _vanBanCubit.selectTrangThaiVanBan(value);
      },
      selectKeyDialog: _vanBanCubit,
      listSelect: const [
        SelectKey.CHO_VAO_SO,
        SelectKey.CHO_XU_LY_VB_DI,
        SelectKey.CHO_XU_LY_VB_DEN,
        SelectKey.CHO_TRINH_KY,
        SelectKey.CHO_CHO_Y_KIEN_VB_DEN,
        SelectKey.CHO_CAP_SO,
        SelectKey.CHO_BAN_HANH
      ],
      dialogSelect: DialogSettingWidget(
        type: widget.homeItemType,
        listSelectKey: <DialogData>[
          DialogData(
            initValue: _vanBanCubit.selectKeyTime,
            onSelect: (value, startDate, endDate) {
              _vanBanCubit.selectDate(
                  selectKey: value, startDate: startDate, endDate: endDate);
            },
            title: S.current.time,
          ),
        ],
      ),
      child: LoadingOnly(
        stream: _vanBanCubit.stateStream,
        child: StreamBuilder<List<DocumentModel>>(
          stream: _vanBanCubit.getDanhSachVb,
          builder: (context, snapshot) {
            final data = snapshot.data ?? <DocumentModel>[];
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
                  child: ContainerInfoWidget(
                    title: result.title,
                    status: result.status,
                    colorStatus: result.documentStatus.getColor(),
                    listData: [
                      InfoData(
                        urlIcon: ImageAssets.icSoKyHieu,
                        key: S.current.so_ky_hieu,
                        value: result.kyHieu,
                      ),
                      InfoData(
                        urlIcon: ImageAssets.icAddress,
                        key: S.current.noi_gui,
                        value: result.noiGui,
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
