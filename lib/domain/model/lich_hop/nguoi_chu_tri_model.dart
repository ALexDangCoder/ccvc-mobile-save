class NguoiChutriModel {
  final String tenDonVi;
  final String userId;

  final String hoTen;

  final String userTaoHoId;

  final String id;
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
