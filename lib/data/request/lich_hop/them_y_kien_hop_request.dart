
import 'package:json_annotation/json_annotation.dart';

part 'them_y_kien_hop_request.g.dart';

@JsonSerializable()
class ThemYKienRequest {
  String? content;
  String? phienHopId;
  String? scheduleId;
  String? scheduleOpinionId;

  ThemYKienRequest(
      {this.content, this.phienHopId, this.scheduleOpinionId, this.scheduleId});


  factory ThemYKienRequest.fromJson(Map<String, dynamic> json) =>
      _$ThemYKienRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ThemYKienRequestToJson(this);
}