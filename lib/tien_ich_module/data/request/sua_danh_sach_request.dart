import 'package:json_annotation/json_annotation.dart';

part 'sua_danh_sach_request.g.dart';

@JsonSerializable()
class SuaDanhBaCaNhanRequest {
  String? groups;
  String? hoTen;
  String? phone_DiDong;
  String? phone_CoQuan;
  String? phone_NhaRieng;
  String? email;
  bool? gioiTinh;
  String? ngaySinh;
  String? cmtnd;
  String? anhDaiDien_FilePath;
  String? anhChuKy_FilePath;
  String? anhChuKyNhay_FilePath;
  String? diaChi;
  bool? isDeleted;
  int? thuTu;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  String? id;

  SuaDanhBaCaNhanRequest({
    required this.groups,
    required this.hoTen,
    required this.phone_DiDong,
    required this.phone_CoQuan,
    required this.phone_NhaRieng,
    required this.email,
    required this.gioiTinh,
    required this.ngaySinh,
    required this.cmtnd,
    required this.anhDaiDien_FilePath,
    required this.anhChuKy_FilePath,
    required this.anhChuKyNhay_FilePath,
    required this.diaChi,
    required this.isDeleted,
    required this.thuTu,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.id,
  });

  factory SuaDanhBaCaNhanRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SuaDanhBaCaNhanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SuaDanhBaCaNhanRequestToJson(this);
}
