import 'package:json_annotation/json_annotation.dart';

part 'ngay_tao_nhiem_vu_request.g.dart';

@JsonSerializable()
class NgayTaoNhiemVuRequest {
  @JsonKey(name: 'NgayTaoNhiemVu')
  NgayTaoNhiemVu? ngayTaoNhiemVu;

  NgayTaoNhiemVuRequest({
    required this.ngayTaoNhiemVu,
  });

  factory NgayTaoNhiemVuRequest.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NgayTaoNhiemVuRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NgayTaoNhiemVuRequestToJson(this);
}

@JsonSerializable()
class NgayTaoNhiemVu {
  @JsonKey(name: 'FromDate')
  String? fromDate;
  @JsonKey(name: 'ToDate')
  String? toDate;

  NgayTaoNhiemVu({
    required this.fromDate,
    required this.toDate,
  });

  factory NgayTaoNhiemVu.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NgayTaoNhiemVuFromJson(json);

  Map<String, dynamic> toJson() => _$NgayTaoNhiemVuToJson(this);
}
