import 'package:json_annotation/json_annotation.dart';

part 'chi_tiet_kien_nghi_request.g.dart';

@JsonSerializable()
class ChiTietKienNghiRequest {
  @JsonKey(name: 'KienNghiId')
  final String kienNghiId;
  @JsonKey(name: 'TaskId')
  final String? taskId;

  ChiTietKienNghiRequest({
    required this.kienNghiId,
    required this.taskId,
  });

  factory ChiTietKienNghiRequest.fromJson(Map<String, dynamic> json) =>
      _$ChiTietKienNghiRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietKienNghiRequestToJson(this);
}
