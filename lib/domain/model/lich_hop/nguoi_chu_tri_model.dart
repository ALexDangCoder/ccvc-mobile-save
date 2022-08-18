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
  String? chucVu;
  String? canBoId;
  String? parentId;
  String? tenCoQuan;
  String? tenCanBo;
  String? ghiChu;

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
    this.chucVu,
    this.canBoId,
    this.parentId,
    this.tenCanBo,
    this.tenCoQuan,
    this.ghiChu,
  });

  String title() {
    String title = '';
    if (hoTen != '') {
      title = ' ${hoTen!} - $tenDonVi';
    } else {
      title = tenCoQuan ?? '';
    }
    return title;
  }
}
