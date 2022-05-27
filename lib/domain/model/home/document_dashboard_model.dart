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
  THUONG_KHAN,
  CHO_PHAN_XU_LY,
  DEN_HAN,
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
      case VBDenDocumentType.CHO_PHAN_XU_LY:
        return 'CHO_PHAN_XU_LY';
      case VBDenDocumentType.DEN_HAN:
        return 'DEN_HAN';
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
      case VBDenDocumentType.CHO_PHAN_XU_LY:
        return true;
      case VBDenDocumentType.DEN_HAN:
        return true;
    }
  }
}

extension TypeVBDi on String {
  bool getTrangThaiChoTrinhKy(String trangThai) {
    if (trangThai == 'CHO_TRINH_KY') {
      return true;
    } else if (trangThai == 'DA_XU_LY') {
      return false;
    } else if (trangThai == 'CHO_XU_LY') {
      return false;
    } else {
      return false;
    }
  }

  bool getTrangThaiDaXuLy(String trangThai) {
    if (trangThai == 'CHO_TRINH_KY') {
      return false;
    } else if (trangThai == 'DA_XU_LY') {
      return true;
    } else if (trangThai == 'CHO_XU_LY') {
      return false;
    } else {
      return false;
    }
  }

  bool getTrangThaiChoXuLy(String trangThai) {
    if (trangThai == 'CHO_TRINH_KY') {
      return false;
    } else if (trangThai == 'DA_XU_LY') {
      return false;
    } else if (trangThai == 'CHO_XU_LY') {
      return true;
    } else {
      return false;
    }
  }

  List<int> getTrangThaiNumber() {
    switch (this) {
      case 'CHO_TRINH_KY':
        return [1];
      case 'DA_XU_LY':
        return [];
      case ' CHO_XU_LY':
        return [2];
    }
    return [];
  }

  List<String> daHoanThanh() {
    switch (this) {
      case 'CHO_VAO_SO':
        return ['CHO_VAO_SO'];
      case 'DANG_XU_LY':
        return ['DANG_XU_LY'];
      case 'DA_XU_LY':
        return ['DA_XU_LY'];
      case 'CHO_XU_LY':
        return ['CHO_XU_LY', 'CHO_PHAN_XU_LY'];
      case 'QUA_HAN':
        return ['DANG_THUC_HIEN'];
      case 'TRONG_HAN':
        return ['TRONG_HAN'];
      case 'THUONG_KHAN':
        return ['THUONG_KHAN'];
      case 'CHO_PHAN_XU_LY':
        return ['CHO_PHAN_XU_LY'];
    }
    return [];
  }

  bool isDanhSachDaXuLy() {
    switch (this) {
      case 'CHO_VAO_SO':
        return false;
      case 'DANG_XU_LY':
        return false;
      case 'DA_XU_LY':
        return false;
      case 'CHO_XU_LY':
        return true;
      case 'QUA_HAN':
        return false;
      case 'TRONG_HAN':
        return false;
      case 'THUONG_KHAN':
        return false;
      case 'CHO_PHAN_XU_LY':
        return false;
    }
    return false;
  }
}
