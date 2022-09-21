import 'package:json_annotation/json_annotation.dart';

part 'sua_danh_sach_request.g.dart';

@JsonSerializable()
class SuaDanhBaCaNhanRequest {
  @JsonKey(name: 'groups')
  String? groups;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'phone_DiDong')
  String? phone_DiDong;
  @JsonKey(name: 'phone_CoQuan')
  String? phone_CoQuan;
  @JsonKey(name: 'phone_NhaRieng')
  String? phone_NhaRieng;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'gioiTinh')
  bool? gioiTinh;
  @JsonKey(name: 'ngaySinh')
  String? ngaySinh;
  @JsonKey(name: 'cmtnd')
  String? cmtnd;
  @JsonKey(name: 'anhDaiDien_FilePath')
  String? anhDaiDien_FilePath;
  @JsonKey(name: 'anhChuKy_FilePath')
  String? anhChuKy_FilePath;
  @JsonKey(name: 'anhChuKyNhay_FilePath')
  String? anhChuKyNhay_FilePath;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'thuTu')
  int? thuTu;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'id')
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
