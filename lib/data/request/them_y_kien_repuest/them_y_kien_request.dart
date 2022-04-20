import 'package:json_annotation/json_annotation.dart';

part 'them_y_kien_request.g.dart';

@JsonSerializable()
class ThemYKienRequest {
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'phienHopId')
  String? phienHopId;
  @JsonKey(name: 'scheduleId')
  String? scheduleId;
  @JsonKey(name: 'scheduleOpinionId')
  String? scheduleOpinionId;

  ThemYKienRequest({
    required this.content,
    required this.phienHopId,
    required this.scheduleId,
    required this.scheduleOpinionId,
  });

  factory ThemYKienRequest.fromJson(Map<String, dynamic> json) =>
      _$ThemYKienRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThemYKienRequestToJson(this);
}
