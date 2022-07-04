
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/tong_dai_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tong_dai_response.g.dart';

@JsonSerializable()
class TongDaiResponse {
  @JsonKey(name: 'data')
  DataResponse? data;
  @JsonKey(name: 'message')
  String? message;

  TongDaiResponse(
    this.data,
    this.message,
  );

  factory TongDaiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TongDaiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TongDaiResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'configValue')
  List<PageDataResponse>? configValue;

  DataResponse(
    this.configValue,
  );

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class PageDataResponse {
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'icon')
  String? icon;
  @JsonKey(name: 'color')
  String? color;
  @JsonKey(name: 'background')
  String? background;

  PageDataResponse(
    this.phone,
    this.icon,
    this.color,
    this.background,
  );

  factory PageDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PageDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataResponseToJson(this);

  TongDaiModel toModel() => TongDaiModel(
        phone: phone,
        icon: icon,
        color: color,
        background: background,
      );
}
