import 'package:ccvc_mobile/bao_cao_module/config/resources/styles.dart';
import 'package:ccvc_mobile/config/resources/color.dart';
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TypeStateDiemDanh { MUON, NGHI_LAM, DI_LAM, VE_SOM, NGHI_PHEP, NGHI_LE }

extension StateDiemDanh on TypeStateDiemDanh {
  String get getIcon {
    switch (this) {
      case TypeStateDiemDanh.NGHI_LE:
        return ImageAssets.icNghiLam;
      case TypeStateDiemDanh.MUON:
        return ImageAssets.icMuon;
      case TypeStateDiemDanh.DI_LAM:
        return ImageAssets.icDiLam;
      case TypeStateDiemDanh.NGHI_LAM:
        return ImageAssets.icNghiLam;
      case TypeStateDiemDanh.VE_SOM:
        return ImageAssets.icVeSom ;
      case TypeStateDiemDanh.NGHI_PHEP:
        return ImageAssets.icNghiPhep;
    }
  }

  String getStringDate(String? timeIn, String? timeOut) {
    if (timeIn == null && timeOut != null) {
      return '??:$timeOut';
    }

    if (timeOut == null && timeIn != null) {
      return '$timeIn:??';
    }

    if (timeIn == null && timeOut == null) {
      return '??:??';
    }

    if (timeIn != null && timeOut != null) {
      return '$timeIn:$timeOut';
    }

    return '??:??';
  }
}

