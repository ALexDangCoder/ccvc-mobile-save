import 'package:flutter/cupertino.dart';

import '/generated/l10n.dart';
import '/home_module/config/resources/color.dart';
import 'constants/app_constants.dart';

extension SelectKeyExt on SelectKey {
  String getText() {
    switch (this) {
      case SelectKey.CA_NHAN:
        return S.current.ca_nhan;
      case SelectKey.DON_VI:
        return S.current.unit;
      case SelectKey.HOM_NAY:
        return S.current.today;
      case SelectKey.TUAN_NAY:
        return S.current.this_week;
      case SelectKey.THANG_NAY:
        return S.current.this_month;
      case SelectKey.NAM_NAY:
        return S.current.this_year;
      case SelectKey.CHO_XU_LY_VB_DEN:
        return S.current.cho_xu_ly_vb_den;
      case SelectKey.CHO_CHO_Y_KIEN_VB_DEN:
        return S.current.cho_cho_y_kien_VB_den;
      case SelectKey.CHO_XU_LY:
        return S.current.cho_xu_ly;
      case SelectKey.DANG_XU_LY:
        return S.current.dang_xu_ly;
      case SelectKey.CHO_TIEP_NHAN:
        return S.current.cho_tiep_nhan;
      case SelectKey.LICH_HOP_CUA_TOI:
        return S.current.lich_hop_cua_toi;
      case SelectKey.LICH_DUOC_MOI:
        return S.current.lich_duoc_moi;
      case SelectKey.LICH_HOP_DUOC_MOI:
        return S.current.lich_hop_duoc_moi;
      case SelectKey.LICH_HOP_CAN_DUYET:
        return S.current.lich_hop_can_duyet;
      case SelectKey.CHO_TRINH_KY_VB_DI:
        return S.current.cho_trinh_ky_VB_di;
      case SelectKey.CHO_VAO_SO:
        return S.current.cho_vao_so;
      case SelectKey.CHO_TRINH_KY:
        return S.current.cho_trinh_ky;
      case SelectKey.CHO_CAP_SO:
        return S.current.cho_cap_so;
      case SelectKey.CHO_BAN_HANH:
        return S.current.cho_ban_hanh;
      case SelectKey.CHO_PHAN_XU_LY:
        return S.current.cho_phan_xu_ly;
      case SelectKey.DANG_THUC_HIEN:
        return S.current.dang_thuc_hien;
      case SelectKey.DANH_SACH_CONG_VIEC:
        return S.current.danh_sach_cong_viec;
      case SelectKey.CHO_XU_LY_VB_DI:
        return S.current.cho_xu_ly_vb_di;
      case SelectKey.CHO_DUYET_XU_LY:
        return S.current.cho_duyet_xu_ly;
      case SelectKey.CHO_DUYET_TIEP_NHAN:
        return S.current.cho_duyet_tiep_nhan;
      case SelectKey.TUY_CHON:
        return S.current.tuy_chon;
      case SelectKey.CHO_TIEP_NHAN_XU_LY:
        return S.current.cho_tiep_nhan_xu_ly;
      case SelectKey.CHO_PHAN_CONG_XU_LY:
        return S.current.cho_phan_cong_xu_ly_home;
      case SelectKey.DA_XU_LY:
        return S.current.da_xu_ly;
      case SelectKey.LICH_CHO_XAC_NHAN:
        return S.current.lich_cho_xac_nhan;
      case SelectKey.LICH_CUA_TOI:
        return S.current.lich_cua_toi;
      case SelectKey.CHUA_THUC_HIEN:
        return S.current.chua_thuc_hien;
    }
  }
}

extension DocumentStatusEx on DocumentStatus {
  String getText() {
    switch (this) {
      case DocumentStatus.DEN_HAN:
        return S.current.den_han;
      case DocumentStatus.QUA_HAN:
        return S.current.qua_han;
      case DocumentStatus.CHO_TIEP_NHAN:
        return S.current.cho_tiep_nhan;
      case DocumentStatus.HOAN_THANH:
        return S.current.hoan_thanh;
      case DocumentStatus.CHO_XAC_NHAN:
        return S.current.cho_xac_nhan;
      case DocumentStatus.THAM_GIA:
        return S.current.tham_gia;
      case DocumentStatus.CHO_PHAN_XU_LY:
        return S.current.cho_phan_xu_ly;
      case DocumentStatus.HOA_TOC:
        return S.current.hoa_toc;
      case DocumentStatus.KHAN:
        return S.current.khan;
      case DocumentStatus.BINH_THUONG:
        return S.current.binh_thuong;
      case DocumentStatus.THUONG_KHAN:
        return S.current.thuong_khan;
      case DocumentStatus.CHUA_THUC_HIEN:
        return S.current.chua_thuc_hien;
      case DocumentStatus.DANG_THUC_HIEN:
        return S.current.dang_thuc_hien;
      case DocumentStatus.TRONG_HAN:
        return S.current.trong_han;
    }
  }

  Color getColor() {
    switch (this) {
      case DocumentStatus.DEN_HAN:
        return itemWidgetNotUse;
      case DocumentStatus.QUA_HAN:
        return statusCalenderRed;
      case DocumentStatus.CHO_TIEP_NHAN:
        return itemWidgetNotUse;
      case DocumentStatus.HOAN_THANH:
        return itemWidgetUsing;
      case DocumentStatus.CHO_XAC_NHAN:
        return itemWidgetNotUse;
      case DocumentStatus.THAM_GIA:
        return itemWidgetUsing;
      case DocumentStatus.CHO_PHAN_XU_LY:
        return choXuLyColor;
      case DocumentStatus.HOA_TOC:
        return statusCalenderRed;
      case DocumentStatus.KHAN:
        return choVaoSoColor;
      case DocumentStatus.BINH_THUONG:
        return daXuLyColor;
      case DocumentStatus.THUONG_KHAN:
        return pinkColor;
      case DocumentStatus.CHUA_THUC_HIEN:
        return yellowColor;
      case DocumentStatus.DANG_THUC_HIEN:
        return AqiColor;
      case DocumentStatus.TRONG_HAN:
        return choTrinhKyColor;
    }
  }
}
