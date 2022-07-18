import 'package:json_annotation/json_annotation.dart';

part 'them_phien_hop_response.g.dart';

@JsonSerializable()
class ThemPhienHopResponse {
  @JsonKey(name: 'succeeded')
  bool? succeeded;
 @JsonKey(name: 'code')
  String? code;


  ThemPhienHopResponse(this.succeeded, this.code);

  factory ThemPhienHopResponse.fromJson(Map<String, dynamic> json) =>
      _$ThemPhienHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThemPhienHopResponseToJson(this);

  bool get isSuccess => succeeded ?? false;
}
