import 'package:ccvc_mobile/y_kien_nguoi_dan_module/domain/model/y_kien_nguoi_dan/dash_boarsh_yknd_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dash_board_yknd_response.g.dart';

@JsonSerializable()
class DashBoashTinhHinhXuLyResponse {
  @JsonKey(name: 'DanhSachKetQua')
  DanhSachKetQuaData danhSachKetQua;

  DashBoashTinhHinhXuLyResponse(this.danhSachKetQua);

  factory DashBoashTinhHinhXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoashTinhHinhXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoashTinhHinhXuLyResponseToJson(this);

  DashboardTinhHinhXuLuModel toDomain() => DashboardTinhHinhXuLuModel(
    tinhHinhXuLyModel: danhSachKetQua.toDomain(),
  );
}

@JsonSerializable()
class DanhSachKetQuaData {
  @JsonKey(name: 'tinhHinh')
  List<TinhHinhData> listTinhHinh;
  @JsonKey(name: 'tinhTrang')
  List<TinhHinhData> listTrangThai;

  DanhSachKetQuaData(this.listTinhHinh,this.listTrangThai);

  factory DanhSachKetQuaData.fromJson(Map<String, dynamic> json) =>
      _$DanhSachKetQuaDataFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachKetQuaDataToJson(this);

  TinhHinhXuLyModel toDomain() => TinhHinhXuLyModel(
      listTinhHinh: listTinhHinh.map((e) => e.toDomain()).toList(),
      listTrangThai: listTrangThai.map((e) => e.toDomain()).toList(),
  );
}

@JsonSerializable()
class TinhHinhData {
  @JsonKey(name: 'SoLuong')
  int? soLuong;
  @JsonKey(name: 'Status')
  String? status;

  TinhHinhData(this.soLuong, this.status);

  factory TinhHinhData.fromJson(Map<String, dynamic> json) =>
      _$TinhHinhDataFromJson(json);

  Map<String, dynamic> toJson() => _$TinhHinhDataToJson(this);

  TinhHinhModel toDomain() => TinhHinhModel(
    soLuong: soLuong ?? 0,
    status: status ?? '',
  );
}


