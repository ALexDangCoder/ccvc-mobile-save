import 'package:json_annotation/json_annotation.dart';

part 'van_ban_don_vi_request.g.dart';

@JsonSerializable()
class VanBanDonViRequest {
  @JsonKey(name: 'endDate')
  String? endDate;
  @JsonKey(name: 'startDate')
  String? startDate;

  VanBanDonViRequest(this.startDate, this.endDate);

  factory VanBanDonViRequest.fromJson(Map<String, dynamic> json) =>
      _$VanBanDonViRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VanBanDonViRequestToJson(this);
}
