class NguoiChutriModel {
  String? tenDonVi;
  String? userId;

  String? hoTen;

  String? userTaoHoId;

  String? id;
  String? donViId;
  bool? isThuKy;

  NguoiChutriModel({
    this.tenDonVi = '',
    this.userId = '',
    this.hoTen = '',
    this.userTaoHoId = '',
    this.donViId = '',
    this.id = '',
    this.isThuKy,
  });

  String title() {
    return '$hoTen - $tenDonVi';
  }
}
