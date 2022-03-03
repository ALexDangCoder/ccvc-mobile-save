import 'package:ccvc_mobile/domain/model/home/document_model.dart';
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

class PeopleOpinionsTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const PeopleOpinionsTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<PeopleOpinionsTabletWidget> createState() => _PeopleOpinionsState();
}

class _PeopleOpinionsState extends State<PeopleOpinionsTabletWidget> {
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
    return ContainerBackgroundTabletWidget(
      maxHeight: 415,
      title: S.current.people_opinions,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _danCubit,
      listSelect: const [
        SelectKey.CHO_TIEP_NHAN,
        SelectKey.CHO_PHAN_XU_LY,
        SelectKey.CHO_DUYET_XU_LY,
        SelectKey.CHO_DUYET_TIEP_NHAN,
      ],
      onChangeKey: (value){
        if(_danCubit.selectKeyTrangThai !=value){
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
                onSelect: (value,startDate,endDate) {
                  _danCubit.selectDate(
                    selectKey: value,
                    startDate: startDate,
                    endDate: endDate,
                  );
                },
                initValue: _danCubit.selectKeyTime,
                title: S.current.time,
              )
            ],
          );
        }
      ),
      child: Flexible(
        child: LoadingOnly(
          stream: _danCubit.stateStream,
          child: StreamBuilder<List<DocumentModel>>(
            stream: _danCubit.getYKien,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <DocumentModel>[];
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
                      status: result.documentStatus.getText(),
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
            }
          ),
        ),
      ),
    );
  }
}
