import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/home_module/widgets/dialog/show_dialog.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/permision_ex.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/Extension/tab_widget_extension.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/bloc/chi_tiet_lich_hop_cubit.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/cell_thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/tablet/widgets/moi_nguoi_tham_gia_tablet.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/select_only_expand.dart';
import 'package:ccvc_mobile/presentation/chi_tiet_lich_hop/ui/widget/thanh_phan_tham_gia_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/screen_device_extension.dart';
import 'package:ccvc_mobile/widgets/dialog/message_dialog/message_config.dart';
import 'package:ccvc_mobile/widgets/listener/event_bus.dart';
import 'package:ccvc_mobile/widgets/show_buttom_sheet/show_bottom_sheet.dart';
import 'package:ccvc_mobile/widgets/text/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'icon_with_title_widget.dart';

class ThanhPhanThamGiaWidget extends StatefulWidget {
  final DetailMeetCalenderCubit cubit;

  const ThanhPhanThamGiaWidget({Key? key, required this.cubit})
      : super(key: key);

  @override
  _ThanhPhanThamGiaWidgetState createState() => _ThanhPhanThamGiaWidgetState();
}

class _ThanhPhanThamGiaWidgetState extends State<ThanhPhanThamGiaWidget> {
  ThanhPhanThamGiaHopCubit thanhPhanThamGiaHopCubit =
      ThanhPhanThamGiaHopCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleEventBus();
    thanhPhanThamGiaHopCubit.idCuocHop = widget.cubit.idCuocHop;
    _refreshPhanCongThuKy();
  }

  void _refreshPhanCongThuKy() {
    eventBus.on<RefreshPhanCongThuKi>().listen((event) {
      thanhPhanThamGiaHopCubit.callApiThanhPhanThamGia(
        isShowMessage: true,
      );
    });
  }

  void _handleEventBus() {
    eventBus.on<ReloadMeetingDetail>().listen((event) {
      if (event.tabReload.contains(TabWidgetDetailMeet.THANH_PHAN_THAM_GIA)) {
        thanhPhanThamGiaHopCubit.idCuocHop = widget.cubit.idCuocHop;
        thanhPhanThamGiaHopCubit.detailMeetCalenderCubit = widget.cubit;
        thanhPhanThamGiaHopCubit.callApiThanhPhanThamGia();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return screenDevice(
      mobileScreen: SelectOnlyWidget(
        onchange: (vl) {
          if (vl && isMobile()) {
            thanhPhanThamGiaHopCubit.callApiThanhPhanThamGia();
          }
        },
        title: S.current.thanh_phan_tham_gia,
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            if (widget.cubit.isBtnMoiNguoiThamGia())
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: IconWithTiltleWidget(
                  icon: ImageAssets.ic_addUser,
                  title: S.current.moi_nguoi_tham_gia,
                  onPress: () {
                    showBottomSheetCustom(
                      context,
                      title: S.current.them_thanh_phan_tham_gia,
                      child: ThemThanhPhanThamGiaWidget(
                        cubit: thanhPhanThamGiaHopCubit,
                      ),
                    );
                  },
                ),
              ),
            if (widget.cubit.isChuTri() || widget.cubit.isThuKy())
              IconWithTiltleWidget(
                icon: ImageAssets.ic_diemDanh,
                title: S.current.diem_danh,
                onPress: () {
                  if (thanhPhanThamGiaHopCubit.diemDanhIds.isEmpty) {
                    MessageConfig.show(
                      title: S.current.ban_chua_chon_nguoi_diem_danh,
                      messState: MessState.error,
                    );
                    return;
                  }
                  showDiaLog(
                    context,
                    title: S.current.diem_danh,
                    icon: SvgPicture.asset(ImageAssets.icDiemDanh),
                    btnLeftTxt: S.current.khong,
                    btnRightTxt: S.current.dong_y,
                    textContent: S.current.conten_diem_danh,
                    funcBtnRight: () {
                      thanhPhanThamGiaHopCubit.postDiemDanh().then((value) {
                        showDiaLog(
                          context,
                          widthOnlyButton: 150,
                          isOneButton: false,
                          title: S.current.diem_danh,
                          icon: SvgPicture.asset(ImageAssets.icDiemDanh),
                          btnLeftTxt: '',
                          textContent: S.current.diem_danh_ho_nguoi_khac,
                          btnRightTxt: S.current.dong,
                          funcBtnRight: () {},
                        );
                      });
                    },
                  );
                },
              ),
            const SizedBox(
              height: 16,
            ),
            StreamBuilder<List<CanBoModel>>(
              stream: thanhPhanThamGiaHopCubit.thanhPhanThamGiaSubject,
              builder: (context, snapshot) {
                final list = snapshot.data ?? [];
                if (list.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return CellThanhPhanThamGia(
                        cubit: thanhPhanThamGiaHopCubit,
                        diemDanh:
                            widget.cubit.isChuTri() || widget.cubit.isThuKy(),
                        infoModel: list[index],
                        ontap: () {
                          showDiaLog(
                            context,
                            title: S.current.huy_diem_danh,
                            icon: SvgPicture.asset(ImageAssets.icHuyDiemDanh),
                            btnLeftTxt: S.current.khong,
                            btnRightTxt: S.current.dong_y,
                            funcBtnRight: () {
                              thanhPhanThamGiaHopCubit
                                  .postHuyDiemDanh(list[index].id ?? '');
                            },
                            showTablet: true,
                            textContent: S.current.conten_huy_diem_danh,
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const NodataWidget(
                    height: 50,
                  );
                }
              },
            )
          ],
        ),
      ),
      tabletScreen: ThanhPhanThamGiaWidgetTablet(
        cubit: widget.cubit,
      ),
    );
  }
}
