import 'package:ccvc_mobile/generated/l10n.dart';
import 'package:ccvc_mobile/utils/constants/app_constants.dart';
import 'package:ccvc_mobile/utils/constants/image_asset.dart';

enum TongHopNhiemVuType {
  tongSoNV,
  hoanThanhNhiemVu,
  nhiemVuDangThucHien,
  hoanThanhQuaHan,
  dangThucHienTrongHan,
  dangThucHienQuaHan
}

extension TongHopNhiemVuEx on TongHopNhiemVuType {
  String getText() {
    switch (this) {
      case TongHopNhiemVuType.tongSoNV:
        return S.current.tong_so_nhiem_vu;
      case TongHopNhiemVuType.hoanThanhNhiemVu:
        return S.current.hoan_thanh_nhiem_vu;
      case TongHopNhiemVuType.nhiemVuDangThucHien:
        return S.current.nhiem_vu_dang_thuc_hien;
      case TongHopNhiemVuType.hoanThanhQuaHan:
        return S.current.hoan_thanh_qua_han;
      case TongHopNhiemVuType.dangThucHienTrongHan:
        return S.current.dang_thuc_hien_trong_han;
      case TongHopNhiemVuType.dangThucHienQuaHan:
        return S.current.dang_thuc_hien_qua_han;
    }
  }

  String urlImg() {
    switch (this) {
      case TongHopNhiemVuType.tongSoNV:
        return ImageAssets.icTongSoNhiemVu;
      case TongHopNhiemVuType.hoanThanhNhiemVu:
        return ImageAssets.icHoanThanhNhiemVu;
      case TongHopNhiemVuType.nhiemVuDangThucHien:
        return ImageAssets.icNhiemVuDangThucHien;
      case TongHopNhiemVuType.hoanThanhQuaHan:
        return ImageAssets.icHoanThanhQuaHan;
      case TongHopNhiemVuType.dangThucHienTrongHan:
        return ImageAssets.icDangThucHienTrongHan;
      case TongHopNhiemVuType.dangThucHienQuaHan:
        return ImageAssets.icDangThucHienQuaHan;
    }
  }
}

class TongHopNhiemVuModel {
  final String code;
  final String name;
  final int value;
  TongHopNhiemVuType tongHopNhiemVuModel = TongHopNhiemVuType.tongSoNV;
  TongHopNhiemVuModel({
    this.code = '',
    this.name = '',
    this.value = 0,
  }) {
    tongHopNhiemVuModel = fromEnum();
  }
  TongHopNhiemVuType fromEnum() {
    switch (code) {
      case NhiemVuStatus.TONG_SO_NHIEM_VU:
        return TongHopNhiemVuType.tongSoNV;
      case NhiemVuStatus.HOAN_THANH_NHIEM_VU:
        return TongHopNhiemVuType.hoanThanhNhiemVu;
      case NhiemVuStatus.NHIEM_VU_DANG_THUC_HIEN:
        return TongHopNhiemVuType.nhiemVuDangThucHien;
      case NhiemVuStatus.HOAN_THANH_QUA_HAN:
        return TongHopNhiemVuType.hoanThanhQuaHan;
      case NhiemVuStatus.DANG_THUC_HIEN_TRONG_HAN:
        return TongHopNhiemVuType.dangThucHienTrongHan;
      case NhiemVuStatus.DANG_THUC_HIEN_QUA_HAN:
        return TongHopNhiemVuType.dangThucHienQuaHan;
    }
    return TongHopNhiemVuType.tongSoNV;
  }
}
