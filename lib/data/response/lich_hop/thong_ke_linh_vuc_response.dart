import 'package:ccvc_mobile/domain/model/lich_hop/thong_ke_lich_hop/thong_ke_linh_vuc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_ke_linh_vuc_response.g.dart';

@JsonSerializable()
class ThongKeLinhVucResponse {
  @JsonKey(name: 'data')
  List<LinhVucResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ThongKeLinhVucResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory ThongKeLinhVucResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongKeLinhVucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongKeLinhVucResponseToJson(this);

}

@JsonSerializable()
class LinhVucResponse {
  @JsonKey(name: 'linhVucId')
  String? id;
  @JsonKey(name: 'tenLinhVuc')
  String? tenLinhVuc;
  @JsonKey(name: 'soLuongLich')
  int? soLuongLich;


  LinhVucResponse(this.id, this.tenLinhVuc, this.soLuongLich);


  factory LinhVucResponse.fromJson(Map<String, dynamic> json) =>
      _$LinhVucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LinhVucResponseToJson(this);


  ThongKeLinhVucModel toDomain() => ThongKeLinhVucModel(
    id: id ?? '',
    soLuongLich: soLuongLich ?? 0,
    tenLinhVuc: tenLinhVuc ?? '',
  );
}
