
import 'package:ccvc_mobile/diem_danh_module/utils/constants/image_asset.dart';


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
        return ImageAssets.icVeSom;
      case TypeStateDiemDanh.NGHI_PHEP:
        return ImageAssets.icNghiPhep;
    }
  }
}
