class PhamViModel {
  final String chucVu;
  final String donVi;
  final String chucVuId;
  final String ngaySinh;
  final bool isCurrentActive;
  final String userCanBoDepartmentId;
  PhamViModel(
      {required this.chucVu,
      required this.chucVuId,
      required this.ngaySinh,
      required this.isCurrentActive,
      required this.donVi,
      required this.userCanBoDepartmentId});
  String get phamVi => '$chucVu - $donVi';
}
