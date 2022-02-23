import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_lam_viec_dashbroad_right_response.g.dart';

@JsonSerializable()
class LichLamViecDashBroadRightResponse {
  @JsonKey(name: 'data')
  List<DataLichLamViecRightResponse> data;

  LichLamViecDashBroadRightResponse(this.data);

  factory LichLamViecDashBroadRightResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LichLamViecDashBroadRightResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LichLamViecDashBroadRightResponseToJson(this);

  List<LichLamViecDashBroadItem> toDomain() =>
      data.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class DataLichLamViecRightResponse {
  @JsonKey(name: 'numberOfCalendars')
  int? numberOfCalendars;
  @JsonKey(name: 'typeId')
  String? typeId;
  @JsonKey(name: 'typeName')
  String? typeName;

  DataLichLamViecRightResponse();

  factory DataLichLamViecRightResponse.fromJson(Map<String, dynamic> json) =>
      _$DataLichLamViecRightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataLichLamViecRightResponseToJson(this);

  List<Object?> get props => throw [];

  LichLamViecDashBroadItem toDomain() => LichLamViecDashBroadItem(
        numberOfCalendars: numberOfCalendars,
        typeId: typeId,
        typeName: typeName,
      );
}
