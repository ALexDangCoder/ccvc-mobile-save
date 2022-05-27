import 'package:json_annotation/json_annotation.dart';

part 'them_danh_ba_ca_nhan_request.g.dart';

@JsonSerializable()
class ThemDanhBaCaNhanRequest {
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
  List<String>? groupIds;

  ThemDanhBaCaNhanRequest({
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
    required this.groupIds,
  });

  factory ThemDanhBaCaNhanRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ThemDanhBaCaNhanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThemDanhBaCaNhanRequestToJson(this);
}
