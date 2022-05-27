import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_tra_lai.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_su_tra_lai_nhiem_vu_response.g.dart';

@JsonSerializable()
class DataLichSuTraLaiNhiemVuResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<LichSuTraLaiNhiemVuModelResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataLichSuTraLaiNhiemVuResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory DataLichSuTraLaiNhiemVuResponse.fromJson(Map<String, dynamic> json) =>
      _$DataLichSuTraLaiNhiemVuResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataLichSuTraLaiNhiemVuResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LichSuTraLaiNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'NguoiTaoXuLy')
  String? nguoiTaoXuLy;
  @JsonKey(name: 'DonViTaoXuLy')
  String? donViTaoXuLy;
  @JsonKey(name: 'ThoiGianTao')
  String? thoiGianTao;
  @JsonKey(name: 'NoiDung')
  String? noiDung;
  @JsonKey(name: 'NguoiXuLy')
  String? nguoiXuLy;
  @JsonKey(name: 'DonViXuLy')
  String? donViXuLy;
  @JsonKey(name: 'FileDinhKems')
  List<FileDinhKemsResponse>? fileDinhKems;
  @JsonKey(name: 'HoatDong')
  String? hoatDong;

  LichSuTraLaiNhiemVuModelResponse({
    this.nguoiTaoXuLy,
    this.donViTaoXuLy,
    this.thoiGianTao,
    this.noiDung,
    this.nguoiXuLy,
    this.donViXuLy,
    this.fileDinhKems,
    this.hoatDong,
  });

  factory LichSuTraLaiNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LichSuTraLaiNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LichSuTraLaiNhiemVuModelResponseToJson(this);

  LichSuTraLaiNhiemVuModel toModel() => LichSuTraLaiNhiemVuModel(
        nguoiTaoXuLy: nguoiTaoXuLy,
        donViTaoXuLy: donViTaoXuLy,
        thoiGianTao: thoiGianTao,
        noiDung: noiDung,
        nguoiXuLy: nguoiXuLy,
        donViXuLy: donViXuLy,
        fileDinhKems: fileDinhKems?.map((e) => e.toModel()).toList() ?? [],
        hoatDong: hoatDong,
      );

  @override
  List<Object?> get props => [];
}
