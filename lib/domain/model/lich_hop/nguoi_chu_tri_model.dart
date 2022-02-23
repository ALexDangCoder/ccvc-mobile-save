class NguoiChutriModel {
  final String tenDonVi;
  final String userId;

  final String hoTen;

  final String userTaoHoId;

  final String id;

  NguoiChutriModel(
      {this.tenDonVi = '',
      this.userId = '',
      this.hoTen = '',
      this.userTaoHoId = '',
      this.id = ''});
  String title() {
    return '$hoTen - $tenDonVi';
  }
}
