class NguoiChutriModel {
  String? tenDonVi;
  String? userId;

  String? hoTen;

  String? userTaoHoId;

  String? id;
  String? donViId;
  bool? isThuKy;
  int? vaiTroThamGia;
  int? trangThai;

  NguoiChutriModel({
    this.tenDonVi = '',
    this.userId = '',
    this.hoTen = '',
    this.userTaoHoId = '',
    this.donViId = '',
    this.id = '',
    this.isThuKy,
    this.vaiTroThamGia,
    this.trangThai,
  });

  String title() {
    return '$hoTen - $tenDonVi';
  }
}
