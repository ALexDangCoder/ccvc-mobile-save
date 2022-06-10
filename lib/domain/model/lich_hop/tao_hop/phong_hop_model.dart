class PhongHopModel {
  int sucChua;
  bool bit_TTDH;
  String diaChi;
  String donViDuyetId;
  String ten;
  String id;
  int trangThai;
  List<ThietBiModel> listThietBi;

  PhongHopModel({
    required this.sucChua,
    required this.bit_TTDH,
    required this.diaChi,
    required this.donViDuyetId,
    required this.ten,
    required this.id,
    required this.trangThai,
    required this.listThietBi,
  });
}

class ThietBiModel {
  String? id;
  String? thietBiId;
  int? soLuong;
  String? tenThietBi;
  String? phongHopId;

  ThietBiModel({
    this.id,
    this.thietBiId,
    this.soLuong,
    this.tenThietBi,
    this.phongHopId,
  });

  ThietBiModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    thietBiId = json['ThietBiId'];
    soLuong = json['SoLuong'];
    tenThietBi = json['TenThietBi'];
    phongHopId = json['PhongHopId'];
  }
}
//ten p, suc chua , dia diem trang thai,thiet bi
