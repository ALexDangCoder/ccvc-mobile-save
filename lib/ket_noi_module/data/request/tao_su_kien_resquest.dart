import 'package:json_annotation/json_annotation.dart';

part 'tao_su_kien_resquest.g.dart';

@JsonSerializable()
class TaoSuKienRequest {
  String loaiBaiViet;
  String tieuDe;
  String ngayBatDau;
  String diaDiem;
  bool coXuatBan;
  String noiDung;
  Map<String, String> thongTinLienHe;
  String type;

  TaoSuKienRequest({
    required this.loaiBaiViet,
    required this.tieuDe,
    required this.ngayBatDau,
    required this.diaDiem,
    required this.coXuatBan,
    required this.noiDung,
    required this.thongTinLienHe,
    required this.type,
  });

  factory TaoSuKienRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TaoSuKienRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TaoSuKienRequestToJson(this);
}
