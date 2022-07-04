class DangKyThongTinXeMoiRequest {
  String? id;
  String? userId;
  String? loaiXeMay;
  String? bienKiemSoat;
  String? loaiSoHuu;

  DangKyThongTinXeMoiRequest({
    this.id,
    this.userId,
    this.loaiXeMay,
    this.bienKiemSoat,
    this.loaiSoHuu,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['loaiXeMay'] = loaiXeMay;
    data['bienKiemSoat'] = bienKiemSoat;
    data['loaiSoHuu'] = loaiSoHuu;
    return data;
  }
}
