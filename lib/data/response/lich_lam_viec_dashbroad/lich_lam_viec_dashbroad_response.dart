import 'package:ccvc_mobile/domain/model/lich_lam_viec/lich_lam_viec_dashbroad.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_lam_viec_dashbroad_response.g.dart';

@JsonSerializable()
class LichLamViecDashBroadResponse {
  @JsonKey(name: 'data')
  DataLichLamViecResponse data;

  LichLamViecDashBroadResponse(this.data);

  factory LichLamViecDashBroadResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LichLamViecDashBroadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichLamViecDashBroadResponseToJson(this);
}

@JsonSerializable()
class DataLichLamViecResponse {
  @JsonKey(name: 'countScheduleCaNhan')
  int? countScheduleCaNhan;

//

  DataLichLamViecResponse();

  factory DataLichLamViecResponse.fromJson(Map<String, dynamic> json) =>
      _$DataLichLamViecResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataLichLamViecResponseToJson(this);

  List<Object?> get props => throw [];

  LichLamViecDashBroad toDomain() =>
      LichLamViecDashBroad(countScheduleCaNhan: countScheduleCaNhan);
}
