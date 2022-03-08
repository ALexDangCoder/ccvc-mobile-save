class CongTacChuanBiModel {
  String? trangThai = '';
  String? tenPhong = '';
  String? sucChua = '';
  String? diaDiem = '';
  String? loaiThietBi = '';

  CongTacChuanBiModel({
    required this.trangThai,
    required this.tenPhong,
    required this.sucChua,
    required this.diaDiem,
    required this.loaiThietBi,
  });

  CongTacChuanBiModel.fromDetail();
}
