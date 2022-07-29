import 'package:ccvc_mobile/domain/model/quan_ly_van_ban/bao_cao_thong_ke/van_ban_don_vi_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'van_ban_don_vi_response.g.dart';

@JsonSerializable()
class VanBanDonViResponse {
  @JsonKey(name: 'Data')
  List<VanBanDonViResponseData>? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'Messages')
  String? message;

  VanBanDonViResponse(
    this.data,
    this.isSuccess,
    this.validationResult,
    this.message,
  );

  factory VanBanDonViResponse.fromJson(Map<String, dynamic> json) =>
      _$VanBanDonViResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VanBanDonViResponseToJson(this);
}

@JsonSerializable()
class VanBanDonViResponseData {
  @JsonKey(name: 'Label')
  String? label;
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'DataTrangThai')
  DataTrangThaiResponse? dataTrangThai;
  @JsonKey(name: 'DataXuLy')
  DataXuLyResponse? dataXuLy;

  VanBanDonViResponseData(
    this.label,
    this.donViId,
    this.dataTrangThai,
    this.dataXuLy,
  );

  factory VanBanDonViResponseData.fromJson(Map<String, dynamic> json) =>
      _$VanBanDonViResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$VanBanDonViResponseDataToJson(this);

  VanBanDonViModel toModel() => VanBanDonViModel(
        donViId: donViId ?? '',
        label: label ?? '',
        dataXuLy: dataXuLy?.toModel() ?? DataXuLy.empty(),
        dataTrangThai: dataTrangThai?.toModel() ?? DataTrangThai.empty(),
      );
}

@JsonSerializable()
class DataTrangThaiResponse {
  @JsonKey(name: 'DhoXuLy')
  int? choXuLy;
  @JsonKey(name: 'DangXuLy')
  int? dangXuLy;
  @JsonKey(name: 'DaXuLy')
  int? daXuLy;

  DataTrangThaiResponse(this.choXuLy, this.dangXuLy, this.daXuLy);

  factory DataTrangThaiResponse.fromJson(Map<String, dynamic> json) =>
      _$DataTrangThaiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTrangThaiResponseToJson(this);

  DataTrangThai toModel() => DataTrangThai(
        choXuLy: choXuLy ?? 0,
        dangXuLy: dangXuLy ?? 0,
        daXuLy: daXuLy ?? 0,
      );
}

@JsonSerializable()
class DataXuLyResponse {
  @JsonKey(name: 'QuaHan')
  int? quaHan;
  @JsonKey(name: 'DenHan')
  int? denHan;
  @JsonKey(name: 'TrongHan')
  int? trongHan;

  DataXuLyResponse(this.quaHan, this.denHan, this.trongHan);

  factory DataXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$DataXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataXuLyResponseToJson(this);

  DataXuLy toModel() => DataXuLy(
        denHan: denHan ?? 0,
        quaHan: quaHan ?? 0,
        trongHan: trongHan ?? 0,
      );
}
