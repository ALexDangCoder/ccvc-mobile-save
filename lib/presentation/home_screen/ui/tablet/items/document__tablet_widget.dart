import 'package:ccvc_mobile/domain/model/home/document_model.dart';
import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_den_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_van_ban/ui/tablet/chi_tiet_van_ban_tablet.dart';
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

class DocumentTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const DocumentTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<DocumentTabletWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentTabletWidget> {
  final VanBanCubit _vanBanCubit = VanBanCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _vanBanCubit.selectTrangThaiVanBan(
          _vanBanCubit.selectKey ?? SelectKey.CHO_VAO_SO,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      maxHeight: 415,
      minHeight: 415,
      title: S.current.document,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
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
      onChangeKey: (value) {
        if (_vanBanCubit.selectKey == value) {
          return;
        }
        _vanBanCubit.selectTrangThaiVanBan(value);
      },
      dialogSelect: StreamBuilder<Object>(
          stream: _vanBanCubit.selectKeyDialog,
          builder: (context, snapshot) {
            return DialogSettingWidget(
              type: widget.homeItemType,
              listSelectKey: <DialogData>[
                DialogData(
                  initValue: _vanBanCubit.selectKeyTime,
                  onSelect: (value, startDate, endDate) {
                    _vanBanCubit.selectDate(
                        selectKey: value,
                        startDate: startDate,
                        endDate: endDate);
                  },
                  title: S.current.time,
                )
              ],
            );
          }),
      child: Flexible(
        child: LoadingOnly(
          stream: _vanBanCubit.stateStream,
          child: StreamBuilder<List<DocumentModel>>(
              stream: _vanBanCubit.getDanhSachVb,
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
                        onTap: () {
                          pushScreen(id: result.id, taskId: result.taskId);
                        },
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
                      ),
                    );
                  }),
                );
              }),
        ),
      ),
    );
  }

  void pushScreen({String id = '', String taskId = ''}) {
    if (_vanBanCubit.isVanBanDen) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChiTietVanBanDenTablet(
            taskId: taskId,
            processId: id,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChiTietVanBanTablet(
            id: id,
          ),
        ),
      );
    }
  }
}
