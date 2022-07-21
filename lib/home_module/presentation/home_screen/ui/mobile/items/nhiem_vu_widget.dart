import 'package:ccvc_mobile/nhiem_vu_module/presentation/chi_tiet_nhiem_vu/ui/phone/chi_tiet_nhiem_vu_phone_screen.dart';
import 'package:ccvc_mobile/nhiem_vu_module/presentation/nhiem_vu/ui/main_nhiem_vu/main_nhiem_vu_mobile.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '/home_module/domain/model/home/WidgetType.dart';
import '/home_module/domain/model/home/calendar_metting_model.dart';
import '/home_module/presentation/home_screen/bloc/home_cubit.dart';
import '/home_module/presentation/home_screen/ui/home_provider.dart';
import '/home_module/presentation/home_screen/ui/mobile/widgets/container_backgroud_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/container_info_widget.dart';
import '/home_module/presentation/home_screen/ui/widgets/dialog_setting_widget.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/constants/image_asset.dart';
import '/home_module/utils/enum_ext.dart';
import '/home_module/widgets/text/text/no_data_widget.dart';
import '/home_module/widgets/text/views/loading_only.dart';

class NhiemVuWidget extends StatefulWidget {
  final WidgetType homeItemType;

  const NhiemVuWidget({Key? key, required this.homeItemType}) : super(key: key);

  @override
  State<NhiemVuWidget> createState() => _NhiemVuWidgetState();
}

class _NhiemVuWidgetState extends State<NhiemVuWidget> {
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
    return ContainerBackgroundWidget(
      title: S.current.nhiem_vu,
      spacingTitle: 0,
      minHeight: 0,
      onTapIcon: () {
        HomeProvider.of(context).homeCubit.showDialog(widget.homeItemType);
      },
      onTapTitle: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainNhieVuMobile(),
          ),
        );
      },
      isUnit: true,
      selectKeyDialog: _nhiemVuCubit,
      listSelect: const [
        SelectKey.CHO_PHAN_XU_LY,
        SelectKey.CHUA_THUC_HIEN,
        SelectKey.DANG_THUC_HIEN,
        SelectKey.DANH_SACH_CONG_VIEC
      ],
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
              ],
            );
          }),
      child: LoadingOnly(
        stream: _nhiemVuCubit.stateStream,
        child: StreamBuilder<List<CalendarMeetingModel>>(
            stream: _nhiemVuCubit.getNhiemVu,
            builder: (context, snapshot) {
              final data = snapshot.data ?? <CalendarMeetingModel>[];
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
                            builder: (context) => ChiTietNhiemVuPhoneScreen(
                              id: result.id,
                              isCheck: _nhiemVuCubit.selectKeyDonVi ==
                                      SelectKey.CA_NHAN
                                  ? true
                                  : false,
                            ),
                          ),
                        );
                      },
                      child: ContainerInfoWidget(
                        title: result.title,
                        status: result.trangThaiHanXuLyEnum?.getText() ?? '',
                        colorStatus: result.trangThaiHanXuLyEnum?.getColor(),
                        listData: [
                          InfoData(
                            urlIcon: ImageAssets.icWork,
                            key: S.current.loai_nhiem_vu,
                            value: result.loaiNhiemVu,
                          ),
                          InfoData(
                            urlIcon: ImageAssets.icCalendar,
                            key: S.current.han_xu_ly,
                            value: result.hanXuLy,
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
