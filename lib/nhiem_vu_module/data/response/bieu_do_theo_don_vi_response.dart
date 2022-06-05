import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/bieu_do_theo_don_vi_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bieu_do_theo_don_vi_response.g.dart';

@JsonSerializable()
class BieuDoTheoDonViResponse {
  @JsonKey(name: 'Messages')
  String? message;
  @JsonKey(name: 'StatusCode')
  int? statusCode;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;
  @JsonKey(name: 'Data')
  DataResponse? data;

  BieuDoTheoDonViResponse({
    this.message,
    this.data,
    this.isSuccess,
    this.statusCode,
  });

  factory BieuDoTheoDonViResponse.fromJson(Map<String, dynamic> json) =>
      _$BieuDoTheoDonViResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BieuDoTheoDonViResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'TongSoNhiemVu')
  int? tongSoNhiemVu;
  @JsonKey(name: 'TinhTrangXuLy')
  TinhTrangXuLyResponse? tinhTrangXuLy;
  @JsonKey(name: 'NhiemVuDonVi')
  List<NhiemVuDonViResponse>? nhiemVuDonVi;

  DataResponse(
    this.tongSoNhiemVu,
    this.tinhTrangXuLy,
    this.nhiemVuDonVi,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  BieuDoTheoDonViModel toModel() => BieuDoTheoDonViModel(
        tinhTrangXuLy: tinhTrangXuLy?.toModel(),
        tongSoNhiemVu: tongSoNhiemVu,
        nhiemVuDonVi: nhiemVuDonVi?.map((e) => e.toModel()).toList(),
      );
}

@JsonSerializable()
class NhiemVuDonViResponse {
  @JsonKey(name: 'DonViId')
  String? donViId;
  @JsonKey(name: 'TenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'TinhTrangXuLy')
  TinhTrangXuLyResponse? tinhTrangXuLy;

  NhiemVuDonViResponse(
    this.donViId,
    this.tenDonVi,
    this.tinhTrangXuLy,
  );

  factory NhiemVuDonViResponse.fromJson(Map<String, dynamic> json) =>
      _$NhiemVuDonViResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NhiemVuDonViResponseToJson(this);

  NhiemVuDonViModel toModel() => NhiemVuDonViModel(
        donViId: donViId,
        tenDonVi: tenDonVi,
        tinhTrangXuLy: tinhTrangXuLy?.toModel(),
      );
}

@JsonSerializable()
class TinhTrangXuLyResponse {
  @JsonKey(name: 'ChoPhanXuLy')
  int? choPhanXuLy;
  @JsonKey(name: 'ChuaThucHien')
  int? chuaThucHien;
  @JsonKey(name: 'DangThucHien')
  int? dangThucHien;
  @JsonKey(name: 'DaThucHien')
  int? daThucHien;

  TinhTrangXuLyResponse(
    this.choPhanXuLy,
    this.chuaThucHien,
    this.dangThucHien,
    this.daThucHien,
  );

  factory TinhTrangXuLyResponse.fromJson(Map<String, dynamic> json) =>
      _$TinhTrangXuLyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TinhTrangXuLyResponseToJson(this);

  TinhTrangXuLyModel toModel() => TinhTrangXuLyModel(
        choPhanXuLy: choPhanXuLy,
        chuaThucHien: chuaThucHien,
        dangThucHien: dangThucHien,
        daThucHien: daThucHien,
      );
}
