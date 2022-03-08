class ThanhPhanThamGiaModel {
  String? id = '';
  String? tenDonVi = '';
  String? tebCanBo = '';
  String? vaiTro = '';
  String? ndCongViec = '';
  String? trangThai = '';
  String? diemDanh = '';
  bool statusDiemDanh = false;

  ThanhPhanThamGiaModel({
    this.id,
    this.tenDonVi,
    this.tebCanBo,
    this.vaiTro,
    this.ndCongViec,
    this.trangThai,
    this.diemDanh,
    required this.statusDiemDanh,
  });

  ThanhPhanThamGiaModel.fromDetail();
}
