class DanhSachNguoiThamGiaModel {
  String? tenChucVu;
  bool? diemDanh;
  bool? disable;
  int? trangThai;
  bool? isVangMat;
  String? id;
  String? lichHopId;
  String? donViId;
  String? canBoId;
  String? vaiTro;
  String? ghiChu;
  String? parentId;
  int? vaiTroThamGia;
  String? email;
  String? soDienThoai;
  String? dauMoiLienHe;
  String? tenCanBo;
  String? tenCoQuan;
  bool? isThuKy;
  bool? isThamGiaBocBang;
  String? createAt;

  DanhSachNguoiThamGiaModel({
    this.tenChucVu,
    this.diemDanh,
    this.disable,
    this.trangThai,
    this.isVangMat,
    this.id,
    this.lichHopId,
    this.donViId,
    this.canBoId,
    this.vaiTro,
    this.ghiChu,
    this.parentId,
    this.vaiTroThamGia,
    this.email,
    this.soDienThoai,
    this.dauMoiLienHe,
    this.tenCanBo,
    this.tenCoQuan,
    this.isThuKy,
    this.isThamGiaBocBang,
    this.createAt,
  });
}

String plusString(String? tenCanBo, String? tenCoQuan, String? tenChucVu) {
  final List<String> listChart = [];
  if (tenCanBo?.isNotEmpty ?? false) {
    listChart.add(tenCanBo!);
  }
  if (tenChucVu?.isNotEmpty ?? false) {
    listChart.add(tenChucVu!);
  }
  if (tenCoQuan?.isNotEmpty ?? false) {
    listChart.add(tenCoQuan!);
  }

  return listChart.join(' - ');
}