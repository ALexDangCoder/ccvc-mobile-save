import 'package:ccvc_mobile/ho_tro_ky_thuat_module/domain/model/danh_sach_su_co.dart';
import 'package:ccvc_mobile/ho_tro_ky_thuat_module/utils/extensions/date_time_extension.dart';
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
  @JsonKey(name: 'items')
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
  @JsonKey(name: 'tenThietBi')
  String? tenThietBi;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'thoiGianYeuCau')
  String? thoiGianYeuCau;
  @JsonKey(name: 'districtId')
  String? districtId;
  @JsonKey(name: 'ibuildingIdd')
  String? buildingId;
  @JsonKey(name: 'room')
  String? room;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'idNguoiYeuCau')
  String? idNguoiYeuCau;
  @JsonKey(name: 'idNguoiXuLy')
  String? idNguoiXuLy;
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
  @JsonKey(name: 'ngayHoanThanh')
  String? ngayHoanThanh;
  @JsonKey(name: 'nhanXet')
  String? nhanXet;

  PageDataResponse(
    this.id,
    this.moTaSuCo,
    this.tenThietBi,
    this.soDienThoai,
    this.diaChi,
    this.thoiGianYeuCau,
    this.districtId,
    this.buildingId,
    this.room,
    this.donViId,
    this.idNguoiYeuCau,
    this.nguoiYeuCau,
    this.donVi,
    this.chucVu,
    this.trangThaiXuLy,
    this.idNguoiXuLy,
    this.codeTrangThai,
    this.ketQuaXuLy,
    this.nguoiXuLy,
    this.ngayHoanThanh,
    this.nhanXet,
  );

  factory PageDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PageDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataResponseToJson(this);

  SuCoModel toModel() => SuCoModel(
        codeTrangThai: codeTrangThai,
        chucVu: chucVu,
        idNguoiYeuCau: idNguoiYeuCau,
        districtId: districtId,
        id: id,
        moTaSuCo: moTaSuCo,
        soDienThoai: soDienThoai,
        diaChi: diaChi,
        thoiGianYeuCau: thoiGianYeuCau?.isNotEmpty ?? false
            ? DateTime.parse(thoiGianYeuCau ?? '').formatApiLichSu
            : '',
        nguoiYeuCau: nguoiYeuCau,
        donVi: donVi,
        nhanXet: nhanXet ?? '',
        trangThaiXuLy: trangThaiXuLy,
        ketQuaXuLy: ketQuaXuLy,
        nguoiXuLy: nguoiXuLy,
        idNguoiXuLy: idNguoiXuLy,
        ngayHoanThanh: ngayHoanThanh?.isNotEmpty ?? false
            ? DateTime.parse(ngayHoanThanh ?? '').formatApiLichSu
            : '',
      );
}
