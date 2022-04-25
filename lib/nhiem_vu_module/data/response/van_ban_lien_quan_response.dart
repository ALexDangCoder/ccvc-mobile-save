import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/van_ban_lien_quan.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';

part 'van_ban_lien_quan_response.g.dart';

@JsonSerializable()
class DataVanBanLienQuanNhiemVuResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<VanBanLienQuanNhiemVuModelResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataVanBanLienQuanNhiemVuResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory DataVanBanLienQuanNhiemVuResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataVanBanLienQuanNhiemVuResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataVanBanLienQuanNhiemVuResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class VanBanLienQuanNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'VanBanId')
  String? vanBanId;
  @JsonKey(name: 'NhiemVuId')
  String? nhiemVuId;
  @JsonKey(name: 'SoVanBan')
  String? soVanBan;
  @JsonKey(name: 'NgayVanBan')
  String? ngayVanBan;
  @JsonKey(name: 'NgayBanHanh')
  String? ngayBanHanh;
  @JsonKey(name: 'TrichYeu')
  String? trichYeu;
  @JsonKey(name: 'DaGanVanBan')
  bool? daGanVanBan;
  @JsonKey(name: 'DonViChuTriXuLyId')
  String? donViChuTriXuLyId;
  @JsonKey(name: 'DonViChuTriXuLy')
  String? donViChuTriXuLy;
  @JsonKey(name: 'HinhThucVanBan')
  String? hinhThucVanBan;
  @JsonKey(name: 'File')
  List<FileDinhKemsResponse>? file;
  @JsonKey(name: 'NguonDuLieuVanBanNhiemVu')
  int? nguonDuLieuVanBanNhiemVu;

  VanBanLienQuanNhiemVuModelResponse({
    this.id,
    this.vanBanId,
    this.nhiemVuId,
    this.soVanBan,
    this.ngayVanBan,
    this.ngayBanHanh,
    this.trichYeu,
    this.daGanVanBan,
    this.donViChuTriXuLyId,
    this.donViChuTriXuLy,
    this.hinhThucVanBan,
    this.file,
    this.nguonDuLieuVanBanNhiemVu,
  });

  factory VanBanLienQuanNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$VanBanLienQuanNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VanBanLienQuanNhiemVuModelResponseToJson(this);

  VanBanLienQuanNhiemVuModel toModel() => VanBanLienQuanNhiemVuModel(
        id: id,
        vanBanId: vanBanId,
        nhiemVuId: nhiemVuId,
        soVanBan: soVanBan,
        ngayVanBan: ngayVanBan,
        ngayBanHanh: ngayBanHanh,
        trichYeu: trichYeu,
        daGanVanBan: daGanVanBan,
        donViChuTriXuLyId: donViChuTriXuLyId,
        donViChuTriXuLy: donViChuTriXuLy,
        hinhThucVanBan: hinhThucVanBan,
        file: file?.map((e) => e.toModel()).toList(),
        nguonDuLieuVanBanNhiemVu: nguonDuLieuVanBanNhiemVu,
      );

  @override
  List<Object?> get props => [];
}
