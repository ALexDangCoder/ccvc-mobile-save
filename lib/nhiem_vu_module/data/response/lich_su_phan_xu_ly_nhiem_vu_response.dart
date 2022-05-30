import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_phan_xu_ly.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_su_phan_xu_ly_nhiem_vu_response.g.dart';

@JsonSerializable()
class DataLichSuPhanXuLyNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? message;
  @JsonKey(name: 'Data')
  List<LichSuPhanXuLyNhiemVuModelResponse>? data;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataLichSuPhanXuLyNhiemVuModelResponse({
    this.message,
    this.data,
    this.isSuccess,
  });

  factory DataLichSuPhanXuLyNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataLichSuPhanXuLyNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataLichSuPhanXuLyNhiemVuModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LichSuPhanXuLyNhiemVuModelResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'Stt')
  int? stt;
  @JsonKey(name: 'NguoiGui')
  String? nguoiGui;
  @JsonKey(name: 'DonViGui')
  String? donViGui;
  @JsonKey(name: 'ThoiGian')
  String? thoiGian;
  @JsonKey(name: 'NguoiNhan')
  String? nguoiNhan;
  @JsonKey(name: 'DonViNhan')
  String? donViNhan;
  @JsonKey(name: 'VaiTroXuLy')
  String? vaiTroXuLy;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'TrangThaiId')
  String? trangThaiId;

  LichSuPhanXuLyNhiemVuModelResponse({
    this.id,
    this.stt,
    this.nguoiGui,
    this.donViGui,
    this.thoiGian,
    this.nguoiNhan,
    this.donViNhan,
    this.vaiTroXuLy,
    this.trangThai,
    this.trangThaiId,
  });

  factory LichSuPhanXuLyNhiemVuModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$LichSuPhanXuLyNhiemVuModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LichSuPhanXuLyNhiemVuModelResponseToJson(this);

  LichSuPhanXuLyNhiemVuModel toModel() => LichSuPhanXuLyNhiemVuModel(
        id: id,
        stt: stt,
        nguoiGui: nguoiGui,
        donViGui: donViGui,
        thoiGian: thoiGian,
        nguoiNhan: nguoiNhan,
        donViNhan: donViNhan,
        vaiTroXuLy: vaiTroXuLy,
        trangThai: trangThai,
        trangThaiId: trangThaiId,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
