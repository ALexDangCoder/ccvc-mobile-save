class NhiemVuDashBoardModel {
  int? soLuongChoPhanXuLy = 0;
  int? soLuongDaThucHien = 0;
  int? soLuongDangThucHien = 0;
  int? soLuongChuaThucHien = 0;
  int? soLuongTrongHan = 0;
  int? soLuongQuaHan = 0;
  int? soLuongDenHan = 0;

  NhiemVuDashBoardModel(this.soLuongChoPhanXuLy, this.soLuongDaThucHien,
      this.soLuongDangThucHien, this.soLuongChuaThucHien, this.soLuongTrongHan,
      this.soLuongQuaHan, this.soLuongDenHan);
}
NhiemVuDashBoardModel nhiemVuDashBoardModel=NhiemVuDashBoardModel(1,1,1,1,1,1,1
);

enum NhiemVuType {
  CHO_XU_LY,
  DANG_XU_LY,
  DA_XU_LY,
  CHO_VAO_SO,
  QUA_HAN,
  TRONG_HAN
}

extension TypeNhiemVu on NhiemVuType {
  String getName() {
    switch (this) {
      case NhiemVuType.CHO_XU_LY:
        return 'CHO_XU_LY';
      case NhiemVuType.DANG_XU_LY:
        return 'DANG_XU_LY';
      case NhiemVuType.DA_XU_LY:
        return 'DA_XU_LY';
      case NhiemVuType.CHO_VAO_SO:
        return 'CHO_VAO_SO';
      case NhiemVuType.QUA_HAN:
        return 'QUA_HAN';
      case NhiemVuType.TRONG_HAN:
        return 'TRONG_HAN';
    }
  }
}
