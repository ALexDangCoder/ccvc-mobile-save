
import 'package:ccvc_mobile/domain/locals/hive_local.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/dash_board_lich_hop.dart';
import 'package:ccvc_mobile/domain/model/list_lich_lv/menu_model.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/item_thong_bao.dart';
import 'package:ccvc_mobile/presentation/calender_work/ui/widget/container_menu_widget.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';

class ItemThongBaoModelMyCalender {
  TypeCalendarMenu typeMenu;
  TypeContainer type;
  List<ItemThongBaoModelMyCalender>? listWidget;
  MenuModel? menuModel;

  ItemThongBaoModelMyCalender({
    required this.typeMenu,
    required this.type,
    this.menuModel,
    this.listWidget,
  });
}

List<ItemThongBaoModelMyCalender> listThongBaoMyCalendar = [
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichCuaToi,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichTheoTrangThai,
    type: TypeContainer.expand,
    listWidget: listTheoTrangThaiLichHop,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichTheoLanhDao,
    type: TypeContainer.expand,
    listWidget: listTheoTrangThaiLichHop,
  ),
];

List<ItemThongBaoModelMyCalender> listTheoTrangThaiLichHop = [
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
    typeMenu: TypeCalendarMenu.ChoDuyet,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichHopCanKLCH,
    type: TypeContainer.number,
  ),
  ItemThongBaoModelMyCalender(
    typeMenu: TypeCalendarMenu.LichDaKLCH,
    type: TypeContainer.number,
  ),
  if (HiveLocal.checkPermissionApp(
    permissionType: PermissionType.VPDT,
    permissionTxt: PermissionAppTxt.QUYEN_DUYET_PHONG,
  ))
    ItemThongBaoModelMyCalender(
      typeMenu: TypeCalendarMenu.LichDuyetPhong,
      type: TypeContainer.number,
    ),
];

extension GetDataMenu on TypeCalendarMenu {
  String getIconMobile() {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return ImageAssets.icPerson;
      case TypeCalendarMenu.LichTheoTrangThai:
        return ImageAssets.icLichTheoTrangThai;
      case TypeCalendarMenu.LichTheoLanhDao:
        return ImageAssets.icLichLanhDao;
      default:
        return '';
    }
  }

  String getIconTablet() {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return ImageAssets.icPersonWork.svgToTheme();
      case TypeCalendarMenu.LichTheoTrangThai:
        return ImageAssets.icTheoDangLichCir.svgToTheme();
      case TypeCalendarMenu.LichTheoLanhDao:
        return ImageAssets.icLichLanhDaoCir.svgToTheme();
      default:
        return '';
    }
  }

  int getIndexMenuLichHop(DashBoardLichHopModel data) {
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
      case TypeCalendarMenu.LichDuyetPhong:
        return data.tongSoLichDuyetPhong ?? 0;
      case TypeCalendarMenu.LichDuyetThietBi:
        return data.tongSoLichDuyetThietBi ?? 0;
      case TypeCalendarMenu.LichDuyetKyThuat:
        return data.tongSoLichCoYeuCau ?? 0;
      case TypeCalendarMenu.LichYeuCauChuanBi:
        return data.tongSoLichCoYeuCau ?? 0;

      default:
        return 0;
    }
  }


  String getTitleLichHop() {
    switch (this) {
      case TypeCalendarMenu.LichCuaToi:
        return S.current.lich_cua_toi;

      case TypeCalendarMenu.BaoCaoThongKe:
        return S.current.bao_cao_thong_ke;

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

      case TypeCalendarMenu.LichDaKLCH:
        return S.current.lich_da_klch;

      case TypeCalendarMenu.LichHopCanKLCH:
        return S.current.lich_hop_can_klch;

      case TypeCalendarMenu.ChoDuyet:
        return S.current.cho_duyet;

      case TypeCalendarMenu.LichDuyetPhong:
        return S.current.lich_hop_duyet_phong;

      case TypeCalendarMenu.LichDuyetThietBi:
        return S.current.lich_hop_duyet_thiet_bi;

      case TypeCalendarMenu.LichDuyetKyThuat:
        return S.current.lich_hop_duyet_ky_thuat;

      case TypeCalendarMenu.LichYeuCauChuanBi:
        return S.current.lich_hop_duyet_yeu_cau_chuan_bi;

      default:
        return S.current.lich_cua_toi;
    }
  }

}
