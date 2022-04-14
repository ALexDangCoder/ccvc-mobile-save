class DocumentDashboardModel {
  int? soLuongChoTrinhKy = 0;
  int? soLuongChoXuLy = 0;
  int? soLuongDaXuLy = 0;
  int? soLuongChoYKien = 0;
  int? soLuongDaChoYKien = 0;
  int? soLuongChoBanHanh = 0;
  int? soLuongChoCapSo = 0;
  int? soLuongDaBanHanh = 0;
  int? soLuongNoiBo = 0;
  int? soLuongDaTraLai = 0;
  int? soLuongQuaHan = 0;
  int? soLuongDenHan = 0;
  int? soLuongTrongHan = 0;
  int? soLuongKhongCoHan = 0;
  int? soLuongThuongKhan = 0;
  int? soLuongDangXuLy = 0;
  int? soLuongChoVaoSo = 0;

  DocumentDashboardModel({
    this.soLuongChoTrinhKy,
    this.soLuongChoXuLy,
    this.soLuongDaXuLy,
    this.soLuongChoYKien,
    this.soLuongDaChoYKien,
    this.soLuongChoBanHanh,
    this.soLuongChoCapSo,
    this.soLuongDaBanHanh,
    this.soLuongNoiBo,
    this.soLuongDaTraLai,
    this.soLuongQuaHan,
    this.soLuongDenHan,
    this.soLuongTrongHan,
    this.soLuongKhongCoHan,
    this.soLuongThuongKhan,
    this.soLuongDangXuLy,
    this.soLuongChoVaoSo,
  });
}

enum VBDenDocumentDASHBOARDType {
  CHO_TRINH_KY,
  CHO_XU_LY,
  DA_XU_LY,
}
enum VBDenDocumentType {
  CHO_XU_LY,
  DANG_XU_LY,
  DA_XU_LY,
  CHO_VAO_SO,
  QUA_HAN,
  TRONG_HAN,
  THUONG_KHAN
}

extension TypeVBDen on VBDenDocumentType {
  String getName() {
    switch (this) {
      case VBDenDocumentType.CHO_VAO_SO:
        return 'CHO_VAO_SO';
      case VBDenDocumentType.DANG_XU_LY:
        return 'DANG_XU_LY';
      case VBDenDocumentType.DA_XU_LY:
        return 'DA_XU_LY';
      case VBDenDocumentType.CHO_XU_LY:
        return 'CHO_XU_LY';
      case VBDenDocumentType.QUA_HAN:
        return 'DANG_THUC_HIEN';
      case VBDenDocumentType.TRONG_HAN:
        return 'TRONG_HAN';
      case VBDenDocumentType.THUONG_KHAN:
        return 'THUONG_KHAN';
    }
  }

  bool getTrangThai() {
    switch (this) {
      case VBDenDocumentType.CHO_VAO_SO:
        return true;
      case VBDenDocumentType.DANG_XU_LY:
        return true;
      case VBDenDocumentType.DA_XU_LY:
        return true;
      case VBDenDocumentType.CHO_XU_LY:
        return true;
      case VBDenDocumentType.QUA_HAN:
        return true;
      case VBDenDocumentType.TRONG_HAN:
        return true;
      case VBDenDocumentType.THUONG_KHAN:
        return true;
    }
  }
}

extension TypeVBDi on String {
  // String getNameTrangThai() {
  //   switch (this) {
  //     case VBDenDocumentDASHBOARDType.CHO_TRINH_KY:
  //       return 'CHO_TRINH_KY';
  //     case VBDenDocumentDASHBOARDType.DA_XU_LY:
  //       return 'DA_XU_LY';
  //     case VBDenDocumentDASHBOARDType.CHO_XU_LY:
  //       return 'CHO_XU_LY';
  //   }
  // }

  bool? getTrangThaiBool() {
    switch (this) {
      case 'CHO_TRINH_KY':
        return true;
      case 'DA_XU_LY':
        return true;
      case 'CHO_XU_LY':
        return true;
    }
    return false;
  }
  int? getTrangThaiNumber() {
    switch (this) {
      case 'CHO_TRINH_KY':
        return 1;
      case 'DA_XU_LY':
        return 2;
      case' CHO_XU_LY':
        return null;
    }
  }
}
