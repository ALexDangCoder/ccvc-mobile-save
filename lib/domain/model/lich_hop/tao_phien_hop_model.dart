class TaoPhienHopModel {
  String? id;
  String? lichHopId;
  String? tieuDe;
  String? thoiGianBatDau;
  String? thoiGianKetThuc;
  String? canBoId;
  String? donViId;
  String? createdAt;
  String? updatedAt;
  int? thuTu;
  String? noiDung;
  String? hoTen;
  int? trangThai;
  String? jobId;
  String? referenceId;

  TaoPhienHopModel({
    this.id,
    required this.lichHopId,
    required this.tieuDe,
    required this.thoiGianBatDau,
    required this.thoiGianKetThuc,
    required this.canBoId,
    required this.donViId,
    required this.createdAt,
    required this.updatedAt,
    required this.thuTu,
    required this.noiDung,
    required this.hoTen,
    required this.trangThai,
    required this.jobId,
    required this.referenceId,
  });
}
