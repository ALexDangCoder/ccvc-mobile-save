import 'package:ccvc_mobile/domain/model/chi_tiet_lich_lam_viec/so_luong_phat_bieu_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'so_luong_phat_bieu_response.g.dart';

@JsonSerializable()
class SoLuongPhatBieuResponse {
  @JsonKey(name: 'data')
  SoLuongPhatBieuDataResponse data;

  SoLuongPhatBieuResponse(this.data);

  factory SoLuongPhatBieuResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SoLuongPhatBieuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SoLuongPhatBieuResponseToJson(this);
}

@JsonSerializable()
class SoLuongPhatBieuDataResponse {
  @JsonKey(name: 'danhSachPhatBieu')
  int? danhSachPhatBieu;
  @JsonKey(name: 'choDuyet')
  int? choDuyet;
  @JsonKey(name: 'daDuyet')
  int? daDuyet;
  @JsonKey(name: 'huyDuyet')
  int? huyDuyet;

  SoLuongPhatBieuDataResponse({
    this.danhSachPhatBieu,
    this.choDuyet,
    this.daDuyet,
    this.huyDuyet,
  });

  factory SoLuongPhatBieuDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SoLuongPhatBieuDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SoLuongPhatBieuDataResponseToJson(this);

  @override
  List<Object?> get props => throw [];

  SoLuongPhatBieuModel toDomain() => SoLuongPhatBieuModel(
        danhSachPhatBieu: danhSachPhatBieu ?? 0,
        choDuyet: choDuyet ?? 0,
        daDuyet: daDuyet ?? 0,
        huyDuyet: huyDuyet ?? 0,
      );
}
