class SuaBieuQuyetModel {
  String? id;
  String? lichHopId;
  bool? loaiBieuQuyet;
  String? noiDung;
  bool? quyenBieuQuyet;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  List<DanhSachLuaChonSua>? danhSachLuaChon;
  List<dynamic>? danhSachThanhPhanThamGia;
  String? ngayHop;
  bool? isPublish;
  List<DsLuaChonOldModel>? dsLuaChonOld;
  List<ThanhPhanThamGiaOldModel>? thanhPhanThamGiaOld;
  String? dateStart;
  List<DanhSachThanhPhanThamGiaNewModel>? danhSachThanhPhanThamGiaNew;

  SuaBieuQuyetModel({
    this.id,
    this.lichHopId,
    this.loaiBieuQuyet,
    this.noiDung,
    this.quyenBieuQuyet,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.danhSachLuaChon,
    this.danhSachThanhPhanThamGia,
    this.ngayHop,
    this.isPublish,
    this.dsLuaChonOld,
    this.thanhPhanThamGiaOld,
    this.dateStart,
    this.danhSachThanhPhanThamGiaNew,
  });
}

class DanhSachLuaChonSua {
  String? id;
  String? tenLuaChon;
  String? mauBieuQuyet;

  DanhSachLuaChonSua({this.id, this.tenLuaChon, this.mauBieuQuyet});
}

class DsLuaChonOldModel {
  String? luaChonId;
  String? tenLuaChon;
  String? color;
  int? count;
  List<dynamic>? dsCanBo;

  DsLuaChonOldModel({
    this.luaChonId,
    this.tenLuaChon,
    this.color,
    this.count,
    this.dsCanBo,
  });
}

class ThanhPhanThamGiaOldModel {
  String? bieuQuyetId;
  String? lichHopId;
  String? canBoId;
  String? hoTen;
  String? tenDonVi;
  String? donViId;
  String? id;

  ThanhPhanThamGiaOldModel({
    this.bieuQuyetId,
    this.lichHopId,
    this.canBoId,
    this.hoTen,
    this.tenDonVi,
    this.donViId,
    this.id,
  });
}

class DanhSachThanhPhanThamGiaNewModel {
  String? donViId;
  String? canBoId;
  String? idPhienhopCanbo;

  DanhSachThanhPhanThamGiaNewModel({
    this.donViId,
    this.canBoId,
    this.idPhienhopCanbo,
  });
}
