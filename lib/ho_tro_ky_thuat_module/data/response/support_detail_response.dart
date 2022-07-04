import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support_detail_response.g.dart';

@JsonSerializable()
class SupportDetailResponse {
  @JsonKey(name: 'data')
  GroupResponse? data;

  @JsonKey(name: 'statusCode')
  int? statusCode;

  @JsonKey(name: 'message')
  String? message;

  SupportDetailResponse(this.data, this.statusCode, this.message);

  factory SupportDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SupportDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupportDetailResponseToJson(this);
}

@JsonSerializable()
class GroupResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'moTaSuCo')
  String? moTaSuCo;
  @JsonKey(name: 'tenThietBi')
  String? tenThietBi;
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
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'trangThaiXuLy')
  String? trangThaiXuLy;
  @JsonKey(name: 'ketQuaXuLy')
  String? ketQuaXuLy;
  @JsonKey(name: 'nguoiXuLy')
  String? nguoiXuLy;
  @JsonKey(name: 'nhanXet')
  String? nhanXet;
  @JsonKey(name: 'ngayHoanThanh')
  String? ngayHoanThanh;
  @JsonKey(name: 'loaiSuCo')
  List<String>? loaiSuCo;

  GroupResponse(
    this.id,
    this.moTaSuCo,
    this.tenThietBi,
    this.soDienThoai,
    this.diaChi,
    this.thoiGianYeuCau,
    this.nguoiYeuCau,
    this.donVi,
    this.trangThaiXuLy,
    this.ketQuaXuLy,
    this.nguoiXuLy,
    this.nhanXet,
    this.ngayHoanThanh,
    this.chucVu,
    this.loaiSuCo,
  );

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);

  SupportDetail toDomain() => SupportDetail(
        id: id,
        moTaSuCo: moTaSuCo,
        tenThietBi: tenThietBi,
        soDienThoai: soDienThoai,
        diaChi: diaChi,
        thoiGianYeuCau: thoiGianYeuCau,
        nguoiYeuCau: nguoiYeuCau,
        chucVu: chucVu,
        donVi: donVi,
        trangThaiXuLy: trangThaiXuLy,
        nhanXet: nhanXet,
        ngayHoanThanh: ngayHoanThanh,
        ketQuaXuLy: ketQuaXuLy,
        nguoiXuLy: nguoiXuLy,
        loaiSuCo: loaiSuCo,
      );
}