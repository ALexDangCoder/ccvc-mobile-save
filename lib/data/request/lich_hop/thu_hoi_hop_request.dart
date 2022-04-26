import 'package:json_annotation/json_annotation.dart';

part 'thu_hoi_hop_request.g.dart';

@JsonSerializable()
class ThuHoiHopRequest {
  String? id;
  String? scheduleId;
  int? status;

  ThuHoiHopRequest({
    required this.id,
    required this.scheduleId,
    required this.status,
  });

  factory ThuHoiHopRequest.fromJson(Map<String, dynamic> json) =>
      _$ThuHoiHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThuHoiHopRequestToJson(this);
}
