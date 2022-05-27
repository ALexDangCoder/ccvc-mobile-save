import 'package:json_annotation/json_annotation.dart';

part 'add_file_tao_lich_hop_request.g.dart';

@JsonSerializable()
class AddFileTaoLichHopRequest {
  String? DateFrom;
  String? DateTo;
  String? UserId;
  String? DonViId;

  AddFileTaoLichHopRequest({
    required this.DateFrom,
    required this.DateTo,
    required this.UserId,
    required this.DonViId,
  });

  factory AddFileTaoLichHopRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFileTaoLichHopRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddFileTaoLichHopRequestToJson(this);
}
