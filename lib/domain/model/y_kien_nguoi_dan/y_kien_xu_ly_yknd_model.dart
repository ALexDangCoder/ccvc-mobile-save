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
  String ngayTao;
  String? ngaySua;
  int? type;
  String? tenNguoiChoYKien;
  String? tenNguoiXinYKien;
  List<FileModel>? dSFile;
  String? anhDaiDienNguoiCho;
  String? anhDaiDienNguoiXin;

  YKienXuLyYKNDModel({
    this.id,
    this.kienNghiId,
    this.nguoiXinYKien,
    this.nguoiChoYKien,
    this.daChoYKien,
    this.noiDung,
    this.ngayTao = '',
    this.ngaySua,
    this.type,
    this.tenNguoiChoYKien,
    this.tenNguoiXinYKien,
    this.dSFile,
    this.anhDaiDienNguoiXin,
    this.anhDaiDienNguoiCho,
  });
}

class FileModel {
  String? id;
  String? ten;
  String? duongDan;
  String? dungLuong;
  bool? daKySo;
  bool? daGanQR;
  String? ngayTao;
  String? nguoiTaoId;
  bool? suDung;

  FileModel(
    this.id,
    this.ten,
    this.duongDan,
    this.dungLuong,
    this.daKySo,
    this.daGanQR,
    this.ngayTao,
    this.nguoiTaoId,
    this.suDung,
  );
}
