import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_cong_viec_nhiem_vu/chi_tiet_cong_viec_nhiem_vu_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chi_tiet_cong_viec_nhiem_vu_response.g.dart';

@JsonSerializable()
class DataChiTietCongViecNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? message;
  @JsonKey(name: 'Data')
  ChiTietCongViecNhiemVuModelResponse? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataChiTietCongViecNhiemVuModelResponse({
    this.message,
    this.data,
    this.isSuccess,
  });

  factory DataChiTietCongViecNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataChiTietCongViecNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataChiTietCongViecNhiemVuModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ChiTietCongViecNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'TenDonViThucHien')
  String? tenDonViThucHien;
  @JsonKey(name: 'TenNguoiThucHien')
  String? tenNguoiThucHien;
  @JsonKey(name: 'DonViCaNhanThucHien')
  String? donViCaNhanThucHien;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'TenNguoiGiao')
  String? tenNguoiGiao;
  @JsonKey(name: 'TenDonViGiaoViec')
  String? tenDonViGiaoViec;
  @JsonKey(name: 'MaTrangThai')
  String? maTrangThai;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'MucDoCongViec')
  String? mucDoCongViec;
  @JsonKey(name: 'DanhSachCVLQ')
  List<String>? danhSachCVLQ;
  ChiTietCongViecNhiemVuModelResponse({
    this.hanXuLy,
    this.tenDonViThucHien,
    this.tenNguoiThucHien,
    this.donViCaNhanThucHien,
    this.noiDung,
    this.tenNguoiGiao,
    this.tenDonViGiaoViec,
    this.maTrangThai,
    this.trangThai,
    this.mucDoCongViec,
    this.danhSachCVLQ,
  });

  factory ChiTietCongViecNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ChiTietCongViecNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ChiTietCongViecNhiemVuModelResponseToJson(this);

  ChiTietCongViecNhiemVuModel toModel() => ChiTietCongViecNhiemVuModel(
    hanXuLy:hanXuLy,
    tenDonViThucHien:tenDonViThucHien,
    tenNguoiThucHien:tenNguoiThucHien,
    donViCaNhanThucHien:'$donViCaNhanThucHien -',
    noiDung:noiDung,
    tenNguoiGiao:tenNguoiGiao,
    tenDonViGiaoViec:tenDonViGiaoViec,
    maTrangThai:maTrangThai,
    trangThai:trangThai,
    mucDoCongViec:mucDoCongViec,
    danhSachCVLQ: danhSachCVLQ,
  );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
