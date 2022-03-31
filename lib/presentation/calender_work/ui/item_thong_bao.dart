import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/state_select_widget.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/item_menu_lich_hop.dart';
import 'package:ccvc_mobile/presentation/lich_hop/ui/mobile/lich_hop_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<ItemThongBaoModelMyCalender> listThongBao = [
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichCuaToi,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichTheoTrangThai,
    type: TypeContainer.expand,
    listWidget: listTheoTrangThai,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichTheoLanhDao,
    type: TypeContainer.expand,
    listWidget: listTheoTrangThai,
  ),
];

List<ItemThongBaoModelMyCalender> listTheoTrangThai = [
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichDuocMoi,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichTaoHo,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichHuy,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichThuHoi,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichDaCoBaoCao,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichChuaCoBaoCao,
    type: TypeContainer.number,
  ),
];

enum TypeCalendarMenu {
  LichCuaToi,
  LichTheoTrangThai,
  LichTheoLanhDao,
  LichDuocMoi,
  LichTaoHo,
  LichHuy,
  LichThuHoi,
  LichDaCoBaoCao,
  LichChuaCoBaoCao,
  ChoDuyet,
  LichHopCanKLCH,
  LichDaKLCH,
  BaoCaoThongKe,
  LichDuyetPhong,
  LichDuyetThietBi,
  LichDuyetKyThuat,
  LichYeuCauChuanBi,
}

extension GetPermissionMenu on TypeCalendarMenu {}

extension GetScreenMenu on TypeCalendarMenu {
  bool? getListLichHop(TypeCalendarMenu type) {
    if (this == type) {
      return true;
    } else {
      return null;
    }
  }

  int getIndex(DashBoardLichHopModel data) {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return data.countScheduleCaNhan ?? 0;
      case TypeCalendarMenu.LichTaoHo:
        return data.soLichTaoHo ?? 0;
      case TypeCalendarMenu.LichHuy:
        return data.soLichHuyBo ?? 0;
      case TypeCalendarMenu.LichThuHoi:
        return data.soLichThuHoi ?? 0;
      case TypeCalendarMenu.LichDaCoBaoCao:
        return data.soLichCoBaoCaoDaDuyet ?? 0;
      case TypeCalendarMenu.LichChuaCoBaoCao:
        return data.soLichChuaCoBaoCao ?? 0;
      case TypeCalendarMenu.LichDuocMoi:
        return data.tongLichDuocMoi ?? 0;
      case TypeCalendarMenu.LichHopCanKLCH:
        return data.soLichChuaCoBaoCao ?? 0;
      case TypeCalendarMenu.LichDaKLCH:
        return data.tongSoLichCoBaoCao ?? 0;
      default:
        return 0;
    }
  }

  String getTitle() {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return S.current.lich_cua_toi;

      case TypeCalendarMenu.LichTheoTrangThai:
        return S.current.lich_theo_trang_thai;

      case TypeCalendarMenu.LichTheoLanhDao:
        return S.current.lich_theo_lanh_dao;

      case TypeCalendarMenu.LichDuocMoi:
        return S.current.lich_duoc_moi;

      case TypeCalendarMenu.LichTaoHo:
        return S.current.lich_tao_ho;

      case TypeCalendarMenu.LichHuy:
        return S.current.lich_huy;
      case TypeCalendarMenu.LichChuaCoBaoCao:
        return S.current.lich_chua_co_bao_cao;

      case TypeCalendarMenu.LichThuHoi:
        return S.current.lich_thu_hoi;

      case TypeCalendarMenu.LichDaCoBaoCao:
        return S.current.lich_da_co_bao_cao;

      case TypeCalendarMenu.BaoCaoThongKe:
        return S.current.bao_cao_thong_ke;

      case TypeCalendarMenu.LichDaKLCH:
        return S.current.lich_da_klch;

      case TypeCalendarMenu.LichHopCanKLCH:
        return S.current.lich_hop_can_klch;

      default:
        return S.current.lich_cua_toi;
    }
  }

  Widget getHeader({
    required CalenderCubit cubit,
    required Type_Choose_Option_Day type,
  }) {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          child: type.getTextLLVWidget(
            cubit: cubit,
            textColor: textBodyTime,
          ),
        );

      case TypeCalendarMenu.LichDuocMoi:
        return Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: type.getTextLLVWidget(
                        cubit: cubit,
                        textColor: textBodyTime,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StateSelectWidget(
                      cubit: cubit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case TypeCalendarMenu.LichTaoHo:
        return Padding(
          padding: const EdgeInsets.only(
            top: 32.0,
          ),
          child: type.getTextLLVWidget(
            cubit: cubit,
            textColor: textBodyTime,
          ),
        );

      default:
        return Padding(
          padding: const EdgeInsets.only(
            top: 32.0,
          ),
          child: Text(
            cubit.textDay,
            style: textNormalCustom(color: textBodyTime),
          ),
        );
    }
  }

  Widget getHeaderTablet({
    required bool isHindText,
    required CalenderCubit cubit,
  }) {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return isHindText
            ? Container()
            : Container(
                padding: const EdgeInsets.only(bottom: 28),
                child: Text(
                  cubit.textDay,
                  style: textNormalCustom(color: textBodyTime),
                ),
              );

      case TypeCalendarMenu.LichDuocMoi:
        return isHindText
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  StateSelectWidget(cubit: cubit),
                ],
              )
            : Container(
                padding: const EdgeInsets.only(bottom: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.textDay,
                      style: textNormalCustom(color: textBodyTime),
                    ),
                    StateSelectWidget(cubit: cubit),
                  ],
                ),
              );

      case TypeCalendarMenu.LichTaoHo:
        return isHindText
            ? Container()
            : Container(
                padding: const EdgeInsets.only(bottom: 28),
                child: Text(
                  cubit.textDay,
                  style: textNormalCustom(color: textBodyTime),
                ),
              );

      default:
        return isHindText
            ? Container()
            : Container(
                padding: const EdgeInsets.only(bottom: 28),
                child: Text(
                  cubit.textDay,
                  style: textNormalCustom(color: textBodyTime),
                ),
              );
    }
  }
}
