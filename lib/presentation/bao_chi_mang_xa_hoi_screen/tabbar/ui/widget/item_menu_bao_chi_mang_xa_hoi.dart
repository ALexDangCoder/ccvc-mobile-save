import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/bao_chi_mang_xa_hoi_screen/tabbar/bloc/bao_chi_mang_xa_hoi_cubit.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';

class ItemBaoChiMangXaHoiModel {
  String icon;
  TypeBaoChiMangXaHoiMenu typeMenu;
  TypeContainer type;
  int? index;
  List<ItemBaoChiMangXaHoiModel>? listWidget;
  Function(BuildContext context, BaoChiMangXaHoiBloc cubit) onTap;

  ItemBaoChiMangXaHoiModel({
    required this.icon,
    required this.typeMenu,
    required this.type,
    required this.onTap,
    this.index,
    this.listWidget,
  });
}

List<ItemBaoChiMangXaHoiModel> listBaoChiMangXaHoi = [
  ItemBaoChiMangXaHoiModel(
    icon: ImageAssets.icMenuItemBCMXH,
    typeMenu: TypeBaoChiMangXaHoiMenu.TinTonngHop,
    type: TypeContainer.expand,
    onTap: (BuildContext context, BaoChiMangXaHoiBloc cubit) {
      Navigator.pop(context);
    },
  ),
  ItemBaoChiMangXaHoiModel(
    icon: ImageAssets.icMenuItemBCMXH,
    typeMenu: TypeBaoChiMangXaHoiMenu.LanhDaoTinh,
    type: TypeContainer.expand,
    listWidget: [],
    onTap: (BuildContext context, BaoChiMangXaHoiBloc cubit) {},
  ),
  ItemBaoChiMangXaHoiModel(
    icon: ImageAssets.icMenuItemBCMXH,
    typeMenu: TypeBaoChiMangXaHoiMenu.TinhUy,
    type: TypeContainer.expand,
    listWidget: [],
    onTap: (BuildContext context, BaoChiMangXaHoiBloc cubit) {},
  ),
  ItemBaoChiMangXaHoiModel(
    icon: ImageAssets.icMenuItemBCMXH,
    typeMenu: TypeBaoChiMangXaHoiMenu.HoiDongNhanDanTinh,
    type: TypeContainer.expand,
    listWidget: [],
    onTap: (BuildContext context, BaoChiMangXaHoiBloc cubit) {},
  ),
  ItemBaoChiMangXaHoiModel(
    icon: ImageAssets.icMenuItemBCMXH,
    typeMenu: TypeBaoChiMangXaHoiMenu.UyBanNhanDanTinh,
    type: TypeContainer.expand,
    listWidget: [],
    onTap: (BuildContext context, BaoChiMangXaHoiBloc cubit) {},
  ),
  ItemBaoChiMangXaHoiModel(
    icon: ImageAssets.icMenuItemBCMXH,
    typeMenu: TypeBaoChiMangXaHoiMenu.CacDiaPhuong,
    type: TypeContainer.expand,
    listWidget: [],
    onTap: (BuildContext context, BaoChiMangXaHoiBloc cubit) {},
  ),
  ItemBaoChiMangXaHoiModel(
    icon: ImageAssets.icMenuItemBCMXH,
    typeMenu: TypeBaoChiMangXaHoiMenu.MTQQVaCacDoanThe,
    type: TypeContainer.expand,
    listWidget: [],
    onTap: (BuildContext context, BaoChiMangXaHoiBloc cubit) {},
  ),
];
enum TypeBaoChiMangXaHoiMenu {
  TinTonngHop,
  LanhDaoTinh,
  TinhUy,
  HoiDongNhanDanTinh,
  UyBanNhanDanTinh,
  CacDiaPhuong,
  MTQQVaCacDoanThe
}

extension GetStringTypeMenu on TypeBaoChiMangXaHoiMenu {
  String getTitle() {
    switch (this) {
      case TypeBaoChiMangXaHoiMenu.TinTonngHop:
        return S.current.tin_tong_hop;
      case TypeBaoChiMangXaHoiMenu.LanhDaoTinh:
        return S.current.lanh_dao_tinh;
      case TypeBaoChiMangXaHoiMenu.TinhUy:
        return S.current.tinh_uy;
      case TypeBaoChiMangXaHoiMenu.HoiDongNhanDanTinh:
        return S.current.hoi_dong_nhan_dan_tinh;
      case TypeBaoChiMangXaHoiMenu.UyBanNhanDanTinh:
        return S.current.uy_ban_nhan_dan_tinh;
      case TypeBaoChiMangXaHoiMenu.CacDiaPhuong:
        return S.current.cac_dia_phuong;
      case TypeBaoChiMangXaHoiMenu.MTQQVaCacDoanThe:
        return S.current.mttq_cac_the;
      default:
        return S.current.lich_cua_toi;
    }
  }
}
