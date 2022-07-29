import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/tinh_trang_xu_ly_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tinh_trang_xu_ly_response.g.dart';

@JsonSerializable()
class TinhTrangXuLyResponse {
  @JsonKey(name: 'Data')
  List<TinhTrangXuLyResponseData>? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'Messages')
  String? message;

  TinhTrangXuLyResponse(
    this.data,
    this.isSuccess,
    this.validationResult,
    this.message,
  );

  factory TinhTrangXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$TinhTrangXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TinhTrangXuLyResponseToJson(this);
}

@JsonSerializable()
class TinhTrangXuLyResponseData {
  @JsonKey(name: 'Label')
  String? label;
  @JsonKey(name: 'VanBanDi')
  int? VanBanDi;
  @JsonKey(name: 'VanBanDen')
  int? VanBanDen;

  TinhTrangXuLyResponseData(this.label, this.VanBanDi, this.VanBanDen);

  factory TinhTrangXuLyResponseData.fromJson(Map<String, dynamic> json) =>
      _$TinhTrangXuLyResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TinhTrangXuLyResponseDataToJson(this);

  TinhTrangXuLyModel toModel() => TinhTrangXuLyModel(
        label: label ?? '',
        VanBanDi: VanBanDi ?? 0,
        VanBanDen: VanBanDen ?? 0,
      );
}
