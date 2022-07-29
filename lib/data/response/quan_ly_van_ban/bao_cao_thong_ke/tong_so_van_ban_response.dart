import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/tong_so_van_ban_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tong_so_van_ban_response.g.dart';

@JsonSerializable()
class TongSoVanBanResponse {
  @JsonKey(name: 'Data')
  List<TongSoVanBanResponseData>? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'Messages')
  String? message;

  TongSoVanBanResponse(
    this.data,
    this.isSuccess,
    this.validationResult,
    this.message,
  );

  factory TongSoVanBanResponse.fromJson(Map<String, dynamic> json) =>
      _$TongSoVanBanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TongSoVanBanResponseToJson(this);
}

@JsonSerializable()
class TongSoVanBanResponseData {
  @JsonKey(name: 'Label')
  String? label;
  @JsonKey(name: 'Value')
  int? value;

  TongSoVanBanResponseData(
    this.label,
    this.value,
  );

  factory TongSoVanBanResponseData.fromJson(Map<String, dynamic> json) =>
      _$TongSoVanBanResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TongSoVanBanResponseDataToJson(this);

  TongSoVanBanModel toModel() => TongSoVanBanModel(
        label: label ?? '',
        value: value ?? 0,
      );
}
