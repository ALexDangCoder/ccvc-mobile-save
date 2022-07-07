import 'package:ccvc_mobile/data/response/chi_tiet_lich_lam_viec/time_config_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_config_response.g.dart';

@JsonSerializable()
class DataConfigResponse extends Equatable {
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'data')
  List<TimeConfigResponse>? data;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'succeeded')
  bool? succeeded;

  DataConfigResponse(this.code, this.data, this.message, this.succeeded);

  factory DataConfigResponse.fromJson(Map<String, dynamic> json) =>
      _$DataConfigResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataConfigResponseToJson(this);

  @override
  List<Object?> get props => [];
}
