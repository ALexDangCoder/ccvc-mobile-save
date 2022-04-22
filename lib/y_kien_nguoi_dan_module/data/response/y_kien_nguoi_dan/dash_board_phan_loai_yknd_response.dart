import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/dash_board_phan_loai_mode.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dash_board_phan_loai_yknd_response.g.dart';

@JsonSerializable()
class DashBoashPhanLoaiResponse {
  @JsonKey(name: 'DanhSachKetQua')
  List<DashboardData>? danhSachKetQua;

  DashBoashPhanLoaiResponse(this.danhSachKetQua);

  factory DashBoashPhanLoaiResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoashPhanLoaiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoashPhanLoaiResponseToJson(this);

  PhanLoaiModel toDomain() => PhanLoaiModel(
        listPhanLoai: danhSachKetQua?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class DashboardData {
  @JsonKey(name: 'SoLuong')
  int? soLuong;
  @JsonKey(name: 'TenNguon')
  String? tenNguon;

  DashboardData(this.soLuong, this.tenNguon);

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);

  PhanLoaiDataModel toDomain() => PhanLoaiDataModel(
        soLuong: soLuong ?? 0,
        tenNguon: tenNguon ?? '',
      );
}
