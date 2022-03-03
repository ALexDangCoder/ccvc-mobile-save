import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/config/resources/styles.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/bloc/calender_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/mobile/menu/item_state_lich_duoc_moi.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemThongBaoModel {
  String icon;
  TypeCalendarMenu typeMenu;
  TypeContainer type;
  int? index;
  List<ItemThongBaoModel>? listWidget;
  Function(BuildContext context, CalenderCubit cubit) onTap;

  ItemThongBaoModel({
    required this.icon,
    required this.typeMenu,
    required this.type,
    required this.onTap,
    this.index,
    this.listWidget,
  });
}

List<ItemThongBaoModel> listThongBao = [
  ItemThongBaoModel(
    icon: ImageAssets.icPerson,
    typeMenu: TypeCalendarMenu.LichCuaToi,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {
      cubit.changeScreenMenu(TypeCalendarMenu.LichCuaToi);
      Navigator.pop(context);
    },
  ),
  ItemThongBaoModel(
    icon: ImageAssets.icLichTheoTrangThai,
    typeMenu: TypeCalendarMenu.LichTheoTrangThai,
    type: TypeContainer.expand,
    listWidget: listTheoTrangThai,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: ImageAssets.icLichLanhDao,
    typeMenu: TypeCalendarMenu.LichTheoLanhDao,
    type: TypeContainer.expand,
    listWidget: listLanhDao,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
];

List<ItemThongBaoModel> listThongBaoMyCalendar = [
  ItemThongBaoModel(
    icon: ImageAssets.icPerson,
    typeMenu: TypeCalendarMenu.LichCuaToi,
    type: TypeContainer.expand,
    onTap: (BuildContext context, CalenderCubit cubit) {
      cubit.changeScreenMenu(TypeCalendarMenu.LichCuaToi);
    },
  ),
  ItemThongBaoModel(
    icon: ImageAssets.icLichTheoTrangThai,
    typeMenu: TypeCalendarMenu.LichHopLanhDao,
    type: TypeContainer.expand,
    listWidget: listTheoTrangThai,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: ImageAssets.icLichLanhDao,
    typeMenu: TypeCalendarMenu.BaoCaoThongKe,
    type: TypeContainer.expand,
    listWidget: listBaoCaoThongKe,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
];

List<ItemThongBaoModel> listThongBaoTablet = [
  ItemThongBaoModel(
    icon: ImageAssets.icPersonWork,
    typeMenu: TypeCalendarMenu.LichCuaToi,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {
      cubit.changeScreenMenu(TypeCalendarMenu.LichCuaToi);
      Navigator.pop(context);
    },
  ),
  ItemThongBaoModel(
    icon: ImageAssets.icTheoDangLichCir,
    typeMenu: TypeCalendarMenu.LichTheoTrangThai,
    type: TypeContainer.expand,
    listWidget: listTheoTrangThai,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: ImageAssets.icLichLanhDaoCir,
    typeMenu: TypeCalendarMenu.LichTheoLanhDao,
    type: TypeContainer.expand,
    listWidget: listLanhDao,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
];

List<ItemThongBaoModel> listTheoTrangThai = [
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.LichDuocMoi,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {
      cubit.changeScreenMenu(TypeCalendarMenu.LichDuocMoi);
      Navigator.pop(context);
    },
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.LichTaoHo,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {
      cubit.changeScreenMenu(TypeCalendarMenu.LichTaoHo);
      Navigator.pop(context);
    },
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.LichHuy,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.LichThuHoi,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.LichDaCoBaoCao,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.LichChuaCoBaoCao,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
];

List<ItemThongBaoModel> listLanhDao = [
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.LanhDaoUBNDTinh,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.VanPhongUBNDTinh,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.SoKeHoachDauVaDauTu,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.SoNoiVu,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.PhongTaiChinhNoiChinh,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.PhongKinhTeNghanh,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.SoTaiChinh,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.SoNoiVu,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
];

List<ItemThongBaoModel> listBaoCaoThongKe = [
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.ThongKeLichHop,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
  ),
  ItemThongBaoModel(
    icon: '',
    typeMenu: TypeCalendarMenu.DanhSachLichHop,
    type: TypeContainer.number,
    index: 3,
    onTap: (BuildContext context, CalenderCubit cubit) {},
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
  LanhDaoUBNDTinh,
  VanPhongUBNDTinh,
  SoKeHoachDauVaDauTu,
  SoNoiVu,
  PhongTaiChinhNoiChinh,
  PhongKinhTeNghanh,
  SoTaiChinh,
  LichHopLanhDao,
  BaoCaoThongKe,
  ThongKeLichHop,
  DanhSachLichHop
}

extension GetScreenMenu on TypeCalendarMenu {
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

      case TypeCalendarMenu.LanhDaoUBNDTinh:
        return S.current.lanh_dao_ubnd_tinh;

      case TypeCalendarMenu.VanPhongUBNDTinh:
        return S.current.van_phong_ubnd_tinh;

      case TypeCalendarMenu.SoKeHoachDauVaDauTu:
        return S.current.so_ke_hoach_va_dau_tu;

      case TypeCalendarMenu.SoNoiVu:
        return S.current.so_noi_vu;

      case TypeCalendarMenu.PhongTaiChinhNoiChinh:
        return S.current.phong_tai_chinh_noi_chinh;

      case TypeCalendarMenu.PhongKinhTeNghanh:
        return S.current.phong_kinh_te_nghanh;

      case TypeCalendarMenu.SoTaiChinh:
        return S.current.so_tai_chinh;

      case TypeCalendarMenu.LichHopLanhDao:
        return S.current.lich_hop_lanh_dao;

      case TypeCalendarMenu.BaoCaoThongKe:
        return S.current.bao_cao_thong_ke;

      default:
        return S.current.lich_cua_toi;
    }
  }

  Widget getHeader({
    required CalenderCubit cubit,
  }) {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
          child: Text(
            cubit.textDay,
            style: textNormalCustom(color: textBodyTime),
          ),
        );

      case TypeCalendarMenu.LichDuocMoi:
        return Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cubit.textDay,
                      style: textNormalCustom(color: textBodyTime),
                    ),
                    stateLDM.ChoXacNhan.getState(3),
                  ],
                ),
              ),
            ],
          ),
        );

      case TypeCalendarMenu.LichTaoHo:
        return Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
          child: Text(
            cubit.textDay,
            style: textNormalCustom(color: textBodyTime),
          ),
        );

      default:
        return Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
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
                  stateLDM.ChoXacNhan.getState(3),
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
                    stateLDM.ChoXacNhan.getState(3),
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
