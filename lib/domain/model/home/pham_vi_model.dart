class PhamViModel {
  final String chucVu;
  final String donVi;
  final String chucVuId;
 final String ngaySinh;
 final bool isCurrentActive;
  PhamViModel({required this.chucVu, required this.chucVuId,required this.ngaySinh,required this.isCurrentActive,required this.donVi});
  String get phamVi => '$chucVu - $donVi';
}
