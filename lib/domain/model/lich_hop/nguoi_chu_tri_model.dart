class NguoiChutriModel {
  String? tenDonVi;
  String? userId;

  String? hoTen;

  String? userTaoHoId;

  String? id;
  String? donViId;

  NguoiChutriModel(
      {this.tenDonVi = '',
      this.userId = '',
      this.hoTen = '',
      this.userTaoHoId = '',
      this.donViId = '',
      this.id = ''});

  String title() {
    return '$hoTen - $tenDonVi';
  }
}
