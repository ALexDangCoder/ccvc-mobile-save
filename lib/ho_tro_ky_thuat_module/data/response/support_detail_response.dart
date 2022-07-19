import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/support_detail.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
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
  @JsonKey(name: 'codeTrangThai')
  String? codeTrangThai;
  @JsonKey(name: 'ketQuaXuLy')
  String? ketQuaXuLy;
  @JsonKey(name: 'nguoiXuLy')
  String? nguoiXuLy;
  @JsonKey(name: 'nhanXet')
  String? nhanXet;
  @JsonKey(name: 'districtId')
  String? districtId;
  @JsonKey(name: 'buildingId')
  String? buildingId;
  @JsonKey(name: 'ngayHoanThanh')
  String? ngayHoanThanh;
  @JsonKey(name: 'room')
  String? room;
  @JsonKey(name: 'danhSachSuCo')
  List<DSSuCoResponse>? danhSachSuCo;

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
    this.districtId,
    this.buildingId,
    this.danhSachSuCo,
    this.room,
  );

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GroupResponseToJson(this);

  SupportDetail toDomain() => SupportDetail(
        id: id,
        room: room,
        moTaSuCo: (moTaSuCo ?? '').parseHtml(),
        tenThietBi: tenThietBi,
        soDienThoai: soDienThoai,
        diaChi: diaChi,
        thoiGianYeuCau: thoiGianYeuCau,
        nguoiYeuCau: nguoiYeuCau,
        chucVu: chucVu,
        donVi: donVi,
        codeTrangThai: codeTrangThai,
        trangThaiXuLy: trangThaiXuLy,
        nhanXet: nhanXet,
        districId: districtId,
        buildingId: buildingId,
        ngayHoanThanh: ngayHoanThanh,
        ketQuaXuLy: (ketQuaXuLy ?? '').parseHtml(),
        nguoiXuLy: nguoiXuLy,
        danhSachSuCo: danhSachSuCo?.map((e) => e.tenSuCo ?? '').toList(),
      );
}

@JsonSerializable()
class DSSuCoResponse {
  @JsonKey(name: 'tenSuCo')
  String? tenSuCo;

  DSSuCoResponse(this.tenSuCo);

  factory DSSuCoResponse.fromJson(Map<String, dynamic> json) =>
      _$DSSuCoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DSSuCoResponseToJson(this);
}
