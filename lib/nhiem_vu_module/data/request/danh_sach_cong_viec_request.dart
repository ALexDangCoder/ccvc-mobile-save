import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_cong_viec_request.g.dart';

@JsonSerializable()
class DanhSachCongViecRequest {
  @JsonKey(name: 'HanXuLy')
  Map<String, String>? hanXuLy;
  @JsonKey(name: 'Index')
  int? index;
  @JsonKey(name: 'IsCaNhan')
  bool? isCaNhan;
  @JsonKey(name: 'IsSortByHanXuLy')
  bool? isSortByHanXuLy;
  @JsonKey(name: 'KeySearch')
  String? keySearch;
  @JsonKey(name: 'MangTrangThai')
  List<String>? mangTrangThai;
  @JsonKey(name: 'Size')
  int? size;
  @JsonKey(name: 'TrangThaiHanXuLy')
  int? trangThaiHanXuLy;

  DanhSachCongViecRequest({
    required this.hanXuLy,
    required this.index,
    required this.isCaNhan,
    required this.isSortByHanXuLy,
    required this.keySearch,
    required this.mangTrangThai,
    required this.size,
    required this.trangThaiHanXuLy,
  });

  factory DanhSachCongViecRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachCongViecRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachCongViecRequestToJson(this);
}
