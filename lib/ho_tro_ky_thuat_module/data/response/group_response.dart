import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/thanh_vien.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_response.g.dart';

@JsonSerializable()
class GroupImplResponse {
  @JsonKey(name: 'data')
  GroupDataResponse? data;

  GroupImplResponse(
    this.data,
  );

  factory GroupImplResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupImplResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupImplResponseToJson(this);
}

@JsonSerializable()
class GroupDataResponse {
  @JsonKey(name: 'items')
  List<GroupResponse>? data;

  GroupDataResponse(this.data);

  factory GroupDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataResponseToJson(this);

  List<ThanhVien>? toListThanhVien() =>
      data?.map((e) => e.toThanhVien()).toList();
}

@JsonSerializable()
class GroupResponse {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'phone')
  String? soDienThoai;

  GroupResponse(
    this.name,
    this.id,
    this.chucVu,
    this.soDienThoai,
  );

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);

  ThanhVien toThanhVien() => ThanhVien(
        idThanhVien: id,
        tenThanhVien: name,
        chucVu: chucVu,
        soDienThoai: soDienThoai,
      );
}
