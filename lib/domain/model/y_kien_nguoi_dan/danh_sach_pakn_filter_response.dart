import 'package:ccvc_mobile/data/response/y_kien_nguoi_dan/danh_sach_pakn_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_pakn_filter_response.g.dart';

@JsonSerializable()
class DanhSachPAKNFilterResponse {
  @JsonKey(name: 'Messages')
  List<String>? messages;
  @JsonKey(name: 'Data')
  DataDanhSachPAKNFilterResponse? data;


  DanhSachPAKNFilterResponse(
      this.messages, this.data);

  factory DanhSachPAKNFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhSachPAKNFilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachPAKNFilterResponseToJson(this);
}

@JsonSerializable()
class DataDanhSachPAKNFilterResponse {
  @JsonKey(name: 'PageData')
  List<DanhSachKetQuaPAKNResponse>? listDanhSachKetQuaPAKN;

  DataDanhSachPAKNFilterResponse(this.listDanhSachKetQuaPAKN);

  factory DataDanhSachPAKNFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$DataDanhSachPAKNFilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataDanhSachPAKNFilterResponseToJson(this);
}