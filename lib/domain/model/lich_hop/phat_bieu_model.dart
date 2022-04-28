class PhatBieuModel {
  String? id;
  String? phienHop = '';
  String? nguoiPhatBieu = '';
  String? ndPhatBieu = '';
  String? tthoiGian = '';

  PhatBieuModel({
    required this.phienHop,
    required this.nguoiPhatBieu,
    required this.ndPhatBieu,
    required this.tthoiGian,
    this.id
  });

  PhatBieuModel.fromDetail();
}
