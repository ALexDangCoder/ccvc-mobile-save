class DanhSachKetQuaYKXLModel {
  List<YKienXuLyYKNDModel>? danhSachKetQua;
  String? noiDungThongDiep;
  int? maTraLoi;

  DanhSachKetQuaYKXLModel({
    this.danhSachKetQua,
    this.noiDungThongDiep,
    this.maTraLoi,
  });
}

class YKienXuLyYKNDModel {
  String? id;
  String? kienNghiId;
  String? nguoiXinYKien;
  String? nguoiChoYKien;
  bool? daChoYKien;
  String? noiDung;
  String? ngayTao;
  String? ngaySua;
  int? type;
  String? tenNguoiChoYKien;
  String? tenNguoiXinYKien;
  String? dSFile;

  YKienXuLyYKNDModel({
    this.id,
    this.kienNghiId,
    this.nguoiXinYKien,
    this.nguoiChoYKien,
    this.daChoYKien,
    this.noiDung,
    this.ngayTao,
    this.ngaySua,
    this.type,
    this.tenNguoiChoYKien,
    this.tenNguoiXinYKien,
    this.dSFile,
  });
}
