import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_su_co_response.g.dart';

@JsonSerializable()
class DanhSachSuCoResponse {
  @JsonKey(name: 'data')
  DataResponse? data;
  @JsonKey(name: 'message')
  String? message;

  DanhSachSuCoResponse(
    this.data,
    this.message,
  );

  factory DanhSachSuCoResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachSuCoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhSachSuCoResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'pageData')
  List<PageDataResponse>? pageData;

  DataResponse(
    this.pageData,
  );

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class PageDataResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'moTaSuCo')
  String? moTaSuCo;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'thoiGianYeuCau')
  String? thoiGianYeuCau;
  @JsonKey(name: 'nguoiYeuCau')
  String? nguoiYeuCau;
  @JsonKey(name: 'donVi')
  String? donVi;
  @JsonKey(name: 'trangThaiXuLy')
  String? trangThaiXuLy;
  @JsonKey(name: 'ketQuaXuLy')
  String? ketQuaXuLy;
  @JsonKey(name: 'nguoiXuLy')
  String? nguoiXuLy;
  @JsonKey(name: 'ngayHoanThanh')
  String? ngayHoanThanh;

  PageDataResponse(
    this.id,
    this.moTaSuCo,
    this.soDienThoai,
    this.diaChi,
    this.thoiGianYeuCau,
    this.nguoiYeuCau,
    this.donVi,
    this.trangThaiXuLy,
    this.ketQuaXuLy,
    this.nguoiXuLy,
    this.ngayHoanThanh,
  );

  factory PageDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PageDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataResponseToJson(this);

  DanhSachSuCoModel toModel() => DanhSachSuCoModel(
        id: id,
        moTaSuCo: moTaSuCo,
        soDienThoai: soDienThoai,
        diaChi: diaChi,
        thoiGianYeuCau: thoiGianYeuCau,
        nguoiYeuCau: nguoiYeuCau,
        donVi: donVi,
        trangThaiXuLy: trangThaiXuLy,
        ketQuaXuLy: ketQuaXuLy,
        nguoiXuLy: nguoiXuLy,
        ngayHoanThanh: ngayHoanThanh,
      );
}
