
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';


enum TypeStateDiemDanh { MUON, NGHI_LAM, DI_LAM, VE_SOM, NGHI_PHEP }

extension StateDiemDanh on TypeStateDiemDanh {
  String get getIcon {
    switch (this) {
      case TypeStateDiemDanh.MUON:
        return ImageAssets.icMuon;
      case TypeStateDiemDanh.DI_LAM:
        return ImageAssets.icDiLam;
      case TypeStateDiemDanh.NGHI_LAM:
        return ImageAssets.icNghiLam;
      case TypeStateDiemDanh.VE_SOM:
        return ImageAssets.icDiLam;
      case TypeStateDiemDanh.NGHI_PHEP:
        return ImageAssets.icDiLam;
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
