import '/generated/l10n.dart';
import '/home_module/utils/constants/app_constants.dart';
import '/home_module/utils/constants/image_asset.dart';

enum TongHopNhiemVuType {
  choPhanXuLy,
  chuaThucHien,
  dangThucHien,
  hoanThanhNhiemVu
}

extension TongHopNhiemVuEx on TongHopNhiemVuType {
  String getText() {
    switch (this) {
      case TongHopNhiemVuType.choPhanXuLy:
        return S.current.cho_phan_xu_ly;
      case TongHopNhiemVuType.chuaThucHien:
        return S.current.chua_thuc_hien;
      case TongHopNhiemVuType.dangThucHien:
        return S.current.dang_thuc_hien;
      case TongHopNhiemVuType.hoanThanhNhiemVu:
        return S.current.hoan_thanh_nhiem_vu;
    }
  }

  String urlImg() {
    switch (this) {
      case TongHopNhiemVuType.choPhanXuLy:
        return ImageAssets.icNhiemVuDangThucHien;
      case TongHopNhiemVuType.chuaThucHien:
        return ImageAssets.icDangThucHienQuaHan;
      case TongHopNhiemVuType.dangThucHien:
        return ImageAssets.icDangThucHienTrongHan;
      case TongHopNhiemVuType.hoanThanhNhiemVu:
        return ImageAssets.icHoanThanhNhiemVu;
    }
  }
}

class TongHopNhiemVuModel {
  final String code;
  final String name;
  final int value;
  TongHopNhiemVuType tongHopNhiemVuModel = TongHopNhiemVuType.choPhanXuLy;

  TongHopNhiemVuModel({
    this.code = '',
    this.name = '',
    this.value = 0,
  }) {
    tongHopNhiemVuModel = fromEnum();
  }

  TongHopNhiemVuType fromEnum() {
    switch (code) {
      case NhiemVuStatus.CHO_PHAN_XU_LY:
        return TongHopNhiemVuType.choPhanXuLy;
      case NhiemVuStatus.CHUA_THUC_HIEN:
        return TongHopNhiemVuType.chuaThucHien;
      case NhiemVuStatus.DANG_THUC_HIEN:
        return TongHopNhiemVuType.dangThucHien;
      case NhiemVuStatus.HOAN_THANH_NHIEM_VU:
        return TongHopNhiemVuType.hoanThanhNhiemVu;
    }
    return TongHopNhiemVuType.choPhanXuLy;
  }
}
