import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_thu_hoi.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_su_thu_hoi_nhiem_vu_response.g.dart';

@JsonSerializable()
class DataLichSuThuHoiNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? message;
  @JsonKey(name: 'Data')
  List<LichSuThuHoiNhiemVuModelResponse>? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataLichSuThuHoiNhiemVuModelResponse({
    this.message,
    this.data,
    this.isSuccess,
  });

  factory DataLichSuThuHoiNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataLichSuThuHoiNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataLichSuThuHoiNhiemVuModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LichSuThuHoiNhiemVuModelResponse extends Equatable {
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

  LichSuThuHoiNhiemVuModelResponse({
    this.nguoiTaoXuLy,
    this.donViTaoXuLy,
    this.thoiGianTao,
    this.noiDung,
    this.nguoiXuLy,
    this.donViXuLy,
  });

  factory LichSuThuHoiNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LichSuThuHoiNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LichSuThuHoiNhiemVuModelResponseToJson(this);

  LichSuThuHoiNhiemVuModel toModel() => LichSuThuHoiNhiemVuModel(
        nguoiTaoXuLy: nguoiTaoXuLy,
        donViTaoXuLy: donViTaoXuLy,
        thoiGianTao: thoiGianTao,
        noiDung: noiDung,
        nguoiXuLy: nguoiXuLy,
        donViXuLy: donViXuLy,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
