import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/phone/chi_tiet_lich_hop_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/chi_tiet_lich_hop_screen_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/phone/chi_tiet_lich_lam_viec_screen.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_lam_viec/ui/tablet/chi_tiet_lam_viec_tablet.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/calendar_metting_model.dart';
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

class CalendarWorkTabletWidget extends StatefulWidget {
  final WidgetType homeItemType;
  const CalendarWorkTabletWidget({Key? key, required this.homeItemType})
      : super(key: key);

  @override
  State<CalendarWorkTabletWidget> createState() => _CalendarWorkWidgetState();
}

class _CalendarWorkWidgetState extends State<CalendarWorkTabletWidget> {
  final LichLamViecCubit _lamViecCubit = LichLamViecCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lamViecCubit.callApi();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      HomeProvider.of(context).homeCubit.refreshListen.listen((value) {
        _lamViecCubit.callApi();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBackgroundTabletWidget(
      title: S.current.calendar_work,
      maxHeight: 415,
      minHeight: 415,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      selectKeyDialog: _lamViecCubit,
      dialogSelect: StreamBuilder(
        stream: _lamViecCubit.selectKeyDialog,
        builder: (context, _) => DialogSettingWidget(
          listSelectKey: [
            DialogData(
              initValue: _lamViecCubit.selectKeyTime,
              onSelect: (value, startDate, endDate) {
                _lamViecCubit.selectDate(
                    selectKey: value, startDate: startDate, endDate: endDate);
              },
              title: S.current.time,
            )
          ],
          type: widget.homeItemType,
        ),
      ),
      child: Flexible(
        child: LoadingOnly(
          stream: _lamViecCubit.stateStream,
          child: StreamBuilder<List<CalendarMeetingModel>>(
              stream: _lamViecCubit.getListLichLamViec,
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
                      child: GestureDetector(
                        onTap: () {
                          if(result.screenTypeMetting == ScreenTypeMetting.LICH_LAM_VIEC) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChiTietLamViecTablet(
                                      id: result.id,
                                    ),
                              ),
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailMeetCalenderTablet(
                                      id: result.id,
                                    ),
                              ),
                            );
                          }
                        },
                        child: ContainerInfoWidget(
                          status: result.codeStatus.getText(),
                          colorStatus: result.codeStatus.getColor(),
                          backGroundStatus: true,
                          title: result.title,
                          listData: [
                            InfoData(
                              urlIcon: ImageAssets.icTime,
                              key: S.current.time,
                              value: result.convertTime(),
                            ),
                            InfoData(
                              urlIcon: ImageAssets.icAddress,
                              key: S.current.dia_diem,
                              value: result.address,
                            ),
                            InfoData(
                              urlIcon: ImageAssets.icPeople,
                              key: S.current.nguoi_chu_tri,
                              value: result.nguoiChuTri,
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
}
