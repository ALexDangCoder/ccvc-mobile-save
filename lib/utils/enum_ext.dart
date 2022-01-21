import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';

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
      case SelectKey.LICH_DUYET_PHONG:
        return S.current.lich_duyet_phong;
      case SelectKey.LICH_HOP_DUYET_THIET_BI:
        return S.current.lich_hop_duyet_thiet_bi;
      case SelectKey.LICH_HOP_DUYET_YEU_CAU_CHUAN_BI:
        return S.current.lich_hop_duyet_yeu_cau_tb;
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
    }
  }
}
