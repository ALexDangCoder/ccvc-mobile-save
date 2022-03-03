import 'package:json_annotation/json_annotation.dart';

part 'chon_bien_ban_hop_request.g.dart';

@JsonSerializable()
class ChonBienBanHopRequest {
  int? pageIndex;
  int? pageSize;

  ChonBienBanHopRequest(this.pageIndex, this.pageSize);

  factory ChonBienBanHopRequest.fromJson(Map<String, dynamic> json) =>
      _$ChonBienBanHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChonBienBanHopRequestToJson(this);
}
