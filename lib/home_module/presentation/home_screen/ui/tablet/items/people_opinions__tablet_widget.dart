import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/mobile/chi_tiet_yknd_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_yknd/ui/tablet/chi_tiet_yknd_tablet.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/document_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/container_background_tablet_widget.dart';
import '/home_module/presentation/home_screen/ui/tablet/widgets/scroll_bar_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/utils/enum_ext.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

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
      listSelect: _danCubit.selectKeyPermission,
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
                  startDate: _danCubit.startDate,
                  endDate: _danCubit.endDate
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
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChiTietVanBanTabletScreen(
                              iD:result.id,
                              taskID:result.taskId ,
                            ),
                          ),
                        );
                      },
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
