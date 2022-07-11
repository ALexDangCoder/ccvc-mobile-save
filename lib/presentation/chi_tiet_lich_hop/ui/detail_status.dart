import 'dart:ui';

import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

enum StatusDetail {
  NHAP,
  CHO_DUYET,
  DA_DUYET,
  TU_CHOI_DUYET,
  THU_HOI,
  DANG_DIEN_RA,
  DA_GUI_LOI_MOI,
  XOA,
  HUY
}

extension GetDataStatusDetail on StatusDetail {
  String get getIcon {
    switch (this) {
      case StatusDetail.NHAP:
        return ImageAssets.icNhapDetail;
      case StatusDetail.CHO_DUYET:
        return ImageAssets.icChoDuyetDetail;
      case StatusDetail.DA_DUYET:
        return ImageAssets.icDaDuyetDetail;
      case StatusDetail.TU_CHOI_DUYET:
        return ImageAssets.icTuChoiDuyetDetail;
      case StatusDetail.THU_HOI:
        return ImageAssets.icThuHoiDetail;
      case StatusDetail.DANG_DIEN_RA:
        return ImageAssets.icDangDienRaDetail;
      case StatusDetail.DA_GUI_LOI_MOI:
        return ImageAssets.icDaGuiLoiMoiDetail;
      case StatusDetail.XOA:
        return ImageAssets.icXoaDetail;
      case StatusDetail.HUY:
        return ImageAssets.icHuyDetail;
    }
  }

  String get getText {
    switch (this) {
      case StatusDetail.NHAP:
        return S.current.nhap;
      case StatusDetail.CHO_DUYET:
        return S.current.cho_duyet;
      case StatusDetail.DA_DUYET:
        return S.current.da_duyet;
      case StatusDetail.TU_CHOI_DUYET:
        return S.current.tu_choi_duyet;
      case StatusDetail.THU_HOI:
        return S.current.thu_hoi;
      case StatusDetail.DANG_DIEN_RA:
        return S.current.dang_dien_ra;
      case StatusDetail.DA_GUI_LOI_MOI:
        return S.current.da_gui_loi_moi;
      case StatusDetail.XOA:
        return S.current.xoa;
      case StatusDetail.HUY:
        return S.current.huy;
    }
  }

  Color get getColorText {
    switch (this) {
      case StatusDetail.NHAP:
        return color_667793;
      case StatusDetail.CHO_DUYET:
        return colorFF9F43;
      case StatusDetail.DA_DUYET:
        return color28C76F;
      case StatusDetail.TU_CHOI_DUYET:
        return colorEA5455;
      case StatusDetail.THU_HOI:
        return colorEA5455;
      case StatusDetail.DANG_DIEN_RA:
        return color02C5DD;
      case StatusDetail.DA_GUI_LOI_MOI:
        return color28C76F;
      case StatusDetail.XOA:
        return colorEA5455;
      case StatusDetail.HUY:
        return colorEA5455;
    }
  }
}
