class DanhSachCanBoBieuQuyetModel {
  DataDanhSachCanBoBieuQuyetModel? data;

  DanhSachCanBoBieuQuyetModel({this.data});
}

class DataDanhSachCanBoBieuQuyetModel {
  String? lichHopId;
  String? lichHopTitle;
  List<DanhSachCanBoBieuQuyetMd>? danhSachCanBoBieuQuyet;

  DataDanhSachCanBoBieuQuyetModel({
    this.lichHopId,
    this.lichHopTitle,
    this.danhSachCanBoBieuQuyet,
  });
}

class DanhSachCanBoBieuQuyetMd {
  String? canBoId;
  String? hoTenCanBo;
  String? chucVuCanBo;
  String? donViCanBo;

  DanhSachCanBoBieuQuyetMd({
    this.canBoId,
    this.hoTenCanBo,
    this.chucVuCanBo,
    this.donViCanBo,
  });
}
