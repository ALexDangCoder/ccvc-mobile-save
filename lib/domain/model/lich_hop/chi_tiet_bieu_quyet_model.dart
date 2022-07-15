class ChiTietBieuQuyetModel {
  DataBieuQuyet? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ChiTietBieuQuyetModel({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });
}

class DataBieuQuyet {
  String? id;
  String? idLichHop;
  int? trangThai;
  String? noiDung;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  bool? loaiBieuQuyet;
  bool? quyenBieuQuyet;
  String? thoiGianTaoMoi;
  String? thoiGianCapNhat;
  bool? isPublish;
  List<DanhSachLuaChonModel>? dsLuaChon;
  List<DanhSachThanhPhanThamGiaModel>? dsThanhPhanThamGia;

  DataBieuQuyet({
    this.id,
    this.idLichHop,
    this.trangThai,
    this.noiDung,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.loaiBieuQuyet,
    this.quyenBieuQuyet,
    this.thoiGianTaoMoi,
    this.thoiGianCapNhat,
    this.isPublish,
    this.dsLuaChon,
    this.dsThanhPhanThamGia,
  });
}

class DanhSachLuaChonModel {
  String? luaChonId;
  String? tenLuaChon;
  String? color;
  int? count;
  List<dynamic>? dsCanBo;

  DanhSachLuaChonModel({
  required  this.luaChonId,
  required this.tenLuaChon,
  required this.color,
  required this.count,
  required this.dsCanBo,
  });
}

class DanhSachThanhPhanThamGiaModel {
  String? bieuQuyetId;
  String? lichHopId;
  String? canBoId;
  String? hoTen;
  String? tenDonVi;
  String? donViId;
  String? id;

  DanhSachThanhPhanThamGiaModel({
    this.bieuQuyetId,
    this.lichHopId,
    this.canBoId,
    this.hoTen,
    this.tenDonVi,
    this.donViId,
    this.id,
  });
}
