import 'package:ccvc_mobile/home_module/domain/model/home/document_dashboard_model.dart';
import 'package:ccvc_mobile/home_module/domain/model/home/van_ban_don_vi_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'van_ban_don_vi_response.g.dart';

@JsonSerializable()
class VanBanDonViResponse {
  @JsonKey(name: 'Data')
  Data? data;

  VanBanDonViResponse(
    this.data,
  );

  factory VanBanDonViResponse.fromJson(Map<String, dynamic> json) =>
      _$VanBanDonViResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VanBanDonViResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'VanBanDen')
  VBDen? vbDen;
  @JsonKey(name: 'VanBanDi')
  VBDi? vbDi;

  Data(this.vbDen, this.vbDi);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  VanBanDonViModel toDomain() => VanBanDonViModel(
        vbDen: vbDen?.toDomain() ?? DocumentDashboardModel(),
        vbDi: vbDi?.toDomain() ?? DocumentDashboardModel(),
      );
}

@JsonSerializable()
class VBDen {
  @JsonKey(name: 'ChoVaoSo')
  int? choVaoSo;
  @JsonKey(name: 'ChoXuLy')
  int? choXuLy;
  @JsonKey(name: 'DangXuLy')
  int? dangXuLy;
  @JsonKey(name: 'DaXuLy')
  int? daXuLy;
  @JsonKey(name: 'QuaHan')
  int? quaHan;
  @JsonKey(name: 'TrongHan')
  int? trongHan;
  @JsonKey(name: 'DenHan')
  int? denHan;

  VBDen(
    this.choVaoSo,
    this.choXuLy,
    this.dangXuLy,
    this.daXuLy,
    this.quaHan,
    this.trongHan,
    this.denHan,
  );

  VBDen.empty();

  factory VBDen.fromJson(Map<String, dynamic> json) => _$VBDenFromJson(json);

  Map<String, dynamic> toJson() => _$VBDenToJson(this);

  DocumentDashboardModel toDomain() => DocumentDashboardModel(
        soLuongChoVaoSo: choVaoSo ?? 0,
        soLuongChoXuLy: choXuLy ?? 0,
        soLuongDangXuLy: dangXuLy ?? 0,
        soLuongDaXuLy: daXuLy ?? 0,
        soLuongQuaHan: quaHan ?? 0,
        soLuongTrongHan: trongHan ?? 0,
        soLuongDenHan: denHan ?? 0,
      );
}

@JsonSerializable()
class VBDi {
  @JsonKey(name: 'ChoTrinhKy')
  int? choTrinhKy;
  @JsonKey(name: 'ChoXuLy')
  int? choXuLy;
  @JsonKey(name: 'DaXuLy')
  int? daXuLy;
  @JsonKey(name: 'ChoCapSo')
  int? choCapSo;
  @JsonKey(name: 'ChoBanHanh')
  int? choBanHanh;

  VBDi(
    this.choTrinhKy,
    this.choXuLy,
    this.daXuLy,
    this.choCapSo,
    this.choBanHanh,
  );

  VBDi.empty();

  factory VBDi.fromJson(Map<String, dynamic> json) => _$VBDiFromJson(json);

  Map<String, dynamic> toJson() => _$VBDiToJson(this);

  DocumentDashboardModel toDomain() => DocumentDashboardModel(
        soLuongChoTrinhKy: choTrinhKy ?? 0,
        soLuongChoXuLy: choXuLy ?? 0,
        soLuongDaXuLy: daXuLy ?? 0,
        soLuongChoCapSo: choCapSo ?? 0,
        soLuongChoBanHanh: choBanHanh ?? 0,
      );
}
