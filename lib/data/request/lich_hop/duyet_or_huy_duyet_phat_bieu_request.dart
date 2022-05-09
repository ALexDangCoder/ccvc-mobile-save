import 'package:json_annotation/json_annotation.dart';

part 'duyet_or_huy_duyet_phat_bieu_request.g.dart';

@JsonSerializable()
class DuyetPhatBieuRequest {
  List<String> ids;
  String lichHopId;
  int type;

  DuyetPhatBieuRequest({
    required this.ids,
    required this.lichHopId,
    required this.type,
  });

  factory DuyetPhatBieuRequest.fromJson(Map<String, dynamic> json) =>
      _$DuyetPhatBieuRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DuyetPhatBieuRequestToJson(this);
}
