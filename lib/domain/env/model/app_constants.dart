import 'package:json_annotation/json_annotation.dart';

part 'app_constants.g.dart';

@JsonSerializable()
class AppConstants {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'base_url_gate_way')
  String baseUrlGateWay;

  @JsonKey(name: 'base_url_common')
  String baseUrlCommon;

  @JsonKey(name: 'base_url_CCVC')
  String baseUrlCCVC;

  @JsonKey(name: 'base_url_NOTI')
  String baseUrlNOTI;

  AppConstants(
    this.type,
    this.baseUrlGateWay,
    this.baseUrlCommon,
    this.baseUrlCCVC,
    this.baseUrlNOTI,
  );

  factory AppConstants.fromJson(Map<String, dynamic> json) =>
      _$AppConstantsFromJson(json);
}
