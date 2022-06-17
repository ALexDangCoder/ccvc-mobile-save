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

  @JsonKey(name: 'base_url_DOWNLOAD_QLNV')
  String baseUrlQLNV;
  @JsonKey(name: 'base_url_DOWNLOAD_PANK')
  String baseUrlPAKN;
  @JsonKey(name: 'header_origin')
  String headerOrigin;

  AppConstants(
    this.type,
    this.baseUrlGateWay,
    this.baseUrlCommon,
    this.baseUrlCCVC,
    this.baseUrlNOTI,
    this.baseUrlQLNV,
    this.baseUrlPAKN,
    this.headerOrigin,
  );

  factory AppConstants.fromJson(Map<String, dynamic> json) =>
      _$AppConstantsFromJson(json);
}
