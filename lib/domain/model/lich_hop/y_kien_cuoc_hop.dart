class YkienCuocHopModel {
  String? id;
  String? content;
  String? ChucVu;
  String? nguoiTaoId;
  String? nguoiTao;
  String? ngayTao;
  String? scheduleId;
  List<YkienCuocHopModel>? traLoiYKien;

  YkienCuocHopModel({
    this.id,
    this.content,
    this.ChucVu,
    this.nguoiTaoId,
    this.nguoiTao,
    this.ngayTao,
    this.traLoiYKien,
    this.scheduleId
  });
}