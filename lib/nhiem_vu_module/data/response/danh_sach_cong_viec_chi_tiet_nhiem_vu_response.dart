import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/danh_sach_cong_viec_chi_tiet_nhiem_vu.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_cong_viec_chi_tiet_nhiem_vu_response.g.dart';

@JsonSerializable()
class DataDanhSachCongViecChiTietNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? message;
  @JsonKey(name: 'Data')
  List<DanhSachCongViecChiTietNhiemVuModelResponse>? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataDanhSachCongViecChiTietNhiemVuModelResponse({
    this.message,
    this.data,
    this.isSuccess,
  });

  factory DataDanhSachCongViecChiTietNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataDanhSachCongViecChiTietNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataDanhSachCongViecChiTietNhiemVuModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DanhSachCongViecChiTietNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Stt')
  int? stt;
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'TenCv')
  String? tenCv;
  @JsonKey(name: 'MaCv')
  String? maCv;
  @JsonKey(name: 'TrangThaiHanXuLy')
  int? trangThaiHanXuLy;
  @JsonKey(name: 'NoiDungCongViec')
  String? noiDungCongViec;
  @JsonKey(name: 'DoiTuongThucHien')
  String? doiTuongThucHien;
  @JsonKey(name: 'DonViThucHien')
  String? donViThucHien;
  @JsonKey(name: 'DonViThucHienId')
  String? donViThucHienId;
  @JsonKey(name: 'CaNhanThucHien')
  String? caNhanThucHien;
  @JsonKey(name: 'NguoiThucHienId')
  String? nguoiThucHienId;
  @JsonKey(name: 'NguoiThucHien')
  String? nguoiThucHien;
  @JsonKey(name: 'HanXuLyFormatDate')
  String? hanXuLyFormatDate;
  @JsonKey(name: 'ThoiGianGiaoFormatDate')
  String? thoiGianGiaoFormatDate;
  @JsonKey(name: 'HanXuLy')
  String? hanXuLy;
  @JsonKey(name: 'ThoiGianGiaoViec')
  String? thoiGianGiaoViec;
  @JsonKey(name: 'ThoiGian')
  String? thoiGian;
  @JsonKey(name: 'NguoiGiaoViec')
  String? nguoiGiaoViec;
  @JsonKey(name: 'NguoiXuLy')
  String? nguoiXuLy;
  @JsonKey(name: 'DonVi')
  String? donVi;
  @JsonKey(name: 'NguoiCapNhat')
  String? nguoiCapNhat;
  @JsonKey(name: 'DonViGiaoViec')
  String? donViGiaoViec;
  @JsonKey(name: 'DonViXuLy')
  String? donViXuLy;
  @JsonKey(name: 'DonViGiaoViecId')
  String? donViGiaoViecId;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'MaTrangThai')
  String? maTrangThai;
  @JsonKey(name: 'TrangThaiId')
  String? trangThaiId;
  @JsonKey(name: 'MaNhiemVu')
  String? maNhiemVu;
  @JsonKey(name: 'NhiemVuId')
  String? nhiemVuId;
  @JsonKey(name: 'MucDoCongViecId')
  String? mucDoCongViecId;
  @JsonKey(name: 'MucDoCongViec')
  String? mucDoCongViec;
  @JsonKey(name: 'NoiDungNhiemVu')
  String? noiDungNhiemVu;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'NguoiTao')
  String? nguoiTao;
  @JsonKey(name: 'CurrentDonVi')
  String? currentDonVi;
  @JsonKey(name: 'ActionDate')
  String? actionDate;
  @JsonKey(name: 'CongViecLienQuan')
  String? congViecLienQuan;
  @JsonKey(name: 'IsFromCaNhan')
  bool? isFromCaNhan;
  @JsonKey(name: 'WTrangThai')
  int? wTrangThai;
  @JsonKey(name: 'CoTheCapNhatTinhHinh')
  bool? coTheCapNhatTinhHinh;
  @JsonKey(name: 'CoTheSua')
  bool? coTheSua;
  @JsonKey(name: 'CoTheHuy')
  bool? coTheHuy;
  @JsonKey(name: 'CoTheGan')
  bool? coTheGan;
  @JsonKey(name: 'CoTheXoa')
  bool? coTheXoa;

  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'VanBanLienQuan')
  String? vanBanLienQuan;
  @JsonKey(name: 'FileDinhKems')
  List<FileDinhKemsResponse>? file;

  DanhSachCongViecChiTietNhiemVuModelResponse(
      {this.stt,
      this.id,
      this.tenCv,
      this.maCv,
      this.trangThaiHanXuLy,
      this.noiDungCongViec,
      this.doiTuongThucHien,
      this.donViThucHien,
      this.donViThucHienId,
      this.caNhanThucHien,
      this.nguoiThucHienId,
      this.nguoiThucHien,
      this.hanXuLyFormatDate,
      this.thoiGianGiaoFormatDate,
      this.hanXuLy,
      this.thoiGianGiaoViec,
      this.nguoiGiaoViec,
      this.donViGiaoViec,
      this.donViGiaoViecId,
      this.trangThai,
      this.maTrangThai,
      this.trangThaiId,
      this.maNhiemVu,
      this.nhiemVuId,
      this.mucDoCongViecId,
      this.mucDoCongViec,
      this.noiDungNhiemVu,
      this.nguoiTaoId,
      this.nguoiTao,
      this.currentDonVi,
      this.actionDate,
      this.congViecLienQuan,
      this.isFromCaNhan,
      this.wTrangThai,
      this.coTheCapNhatTinhHinh,
      this.coTheSua,
      this.coTheHuy,
      this.coTheGan,
      this.coTheXoa,
      this.nguoiXuLy,
      this.donViXuLy,
      this.thoiGian,
      this.nguoiCapNhat,
      this.donVi,
      this.noiDung,
      this.vanBanLienQuan,
      this.file});

  factory DanhSachCongViecChiTietNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DanhSachCongViecChiTietNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachCongViecChiTietNhiemVuModelResponseToJson(this);

  DanhSachCongViecChiTietNhiemVuModel toLichSuGiaoViec() =>
      DanhSachCongViecChiTietNhiemVuModel(
        nguoiGiaoViec: nguoiGiaoViec,
        donViGiaoViec: donViGiaoViec,
        thoiGianGiaoViec: thoiGian,
        nguoiThucHien: nguoiXuLy,
        donViThucHien: donViXuLy,
      );

  DanhSachCongViecChiTietNhiemVuModel toLichSuTDTT() =>
      DanhSachCongViecChiTietNhiemVuModel(
        nguoiGiaoViec: nguoiCapNhat,
        donViGiaoViec: donVi,
        thoiGianGiaoViec: thoiGian,
        noiDungCongViec: noiDung,
        vanBanLienQuan: vanBanLienQuan,
        trangThai: trangThai,
        file: file?.map((e) => e.toModel()).toList(),
      );

  DanhSachCongViecChiTietNhiemVuModel toModel() =>
      DanhSachCongViecChiTietNhiemVuModel(
        stt: stt,
        id: id,
        tenCv: tenCv,
        maCv: maCv,
        trangThaiHanXuLy: trangThaiHanXuLy,
        noiDungCongViec: noiDungCongViec,
        doiTuongThucHien: doiTuongThucHien,
        donViThucHien: donViThucHien,
        donViThucHienId: donViThucHienId,
        caNhanThucHien: caNhanThucHien,
        nguoiThucHienId: nguoiThucHienId,
        nguoiThucHien: nguoiThucHien,
        hanXuLyFormatDate: hanXuLyFormatDate,
        thoiGianGiaoFormatDate: thoiGianGiaoFormatDate,
        hanXuLy: hanXuLy,
        thoiGianGiaoViec: thoiGianGiaoViec,
        nguoiGiaoViec: nguoiGiaoViec,
        donViGiaoViec: donViGiaoViec,
        donViGiaoViecId: donViGiaoViecId,
        trangThai: trangThai,
        maTrangThai: maTrangThai,
        trangThaiId: trangThaiId,
        maNhiemVu: maNhiemVu,
        nhiemVuId: nhiemVuId,
        mucDoCongViecId: mucDoCongViecId,
        mucDoCongViec: mucDoCongViec,
        noiDungNhiemVu: noiDungNhiemVu,
        nguoiTaoId: nguoiTaoId,
        nguoiTao: nguoiTao,
        currentDonVi: currentDonVi,
        actionDate: actionDate,
        congViecLienQuan: congViecLienQuan,
        isFromCaNhan: isFromCaNhan,
        wTrangThai: wTrangThai,
        coTheCapNhatTinhHinh: coTheCapNhatTinhHinh,
        coTheSua: coTheSua,
        coTheHuy: coTheHuy,
        coTheGan: coTheGan,
        coTheXoa: coTheXoa,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PostYKienResponse extends Equatable {
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;
  @JsonKey(name: 'Code')
  int? code;
  @JsonKey(name: 'Data')
  dynamic data;

  PostYKienResponse(
    this.isSuccess,
    this.data,
    this.code,
  );

  factory PostYKienResponse.fromJson(Map<String, dynamic> json) =>
      _$PostYKienResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostYKienResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
