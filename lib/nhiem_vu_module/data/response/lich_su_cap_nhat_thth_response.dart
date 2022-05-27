import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_van_ban_response.dart';
import 'package:ccvc_mobile/nhiem_vu_module/domain/model/chi_tiet_nhiem_vu/lich_su_cap_nhat_thth.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_su_cap_nhat_thth_response.g.dart';

@JsonSerializable()
class DataLichSuCapNhatTHTHModelResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<LichSuCapNhatTHTHModelResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataLichSuCapNhatTHTHModelResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory DataLichSuCapNhatTHTHModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataLichSuCapNhatTHTHModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataLichSuCapNhatTHTHModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LichSuCapNhatTHTHModelResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'NguoiCapNhat')
  String? nguoiCapNhat;
  @JsonKey(name: 'DonViCapNhat')
  String? donViCapNhat;
  @JsonKey(name: 'ThoiGian')
  String? thoiGian;
  @JsonKey(name: 'NoiDungCapNhat')
  String? noiDungCapNhat;
  @JsonKey(name: 'TrangThai')
  String? trangThai;
  @JsonKey(name: 'TrangThaiId')
  String? trangThaiId;
  @JsonKey(name: 'FileDinhKems')
  List<FileDinhKemsResponse>? fileDinhKems;

  LichSuCapNhatTHTHModelResponse({
    this.id,
    this.nguoiCapNhat,
    this.donViCapNhat,
    this.thoiGian,
    this.noiDungCapNhat,
    this.trangThai,
    this.trangThaiId,
    this.fileDinhKems,
  });

  factory LichSuCapNhatTHTHModelResponse.fromJson(Map<String, dynamic> json) =>
      _$LichSuCapNhatTHTHModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichSuCapNhatTHTHModelResponseToJson(this);

  LichSuCapNhatTHTHModel toModel() => LichSuCapNhatTHTHModel(
        id: id,
        nguoiCapNhat: nguoiCapNhat,
        donViCapNhat: donViCapNhat,
        thoiGian: thoiGian,
        noiDungCapNhat: noiDungCapNhat,
        trangThai: trangThai,
        trangThaiId: trangThaiId,
        fileDinhKems: fileDinhKems?.map((e) => e.toModel()).toList() ?? [],
      );

  @override
  List<Object?> get props => [];
}
