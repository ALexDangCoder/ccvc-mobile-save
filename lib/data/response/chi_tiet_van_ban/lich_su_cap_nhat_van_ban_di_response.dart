import 'package:ccvc_mobile/data/response/chi_tiet_van_ban/lich_su_thu_hoi_van_ban_di_response.dart';
import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_cap_nhat_van_ban_di_model.dart';
import 'package:ccvc_mobile/tien_ich_module/utils/extensions/date_time_extension.dart';
import 'package:ccvc_mobile/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_su_cap_nhat_van_ban_di_response.g.dart';

@JsonSerializable()
class DataLichSuCapNhatVanBanDiResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<LichSuCapNhatVanBanDiResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataLichSuCapNhatVanBanDiResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory DataLichSuCapNhatVanBanDiResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataLichSuCapNhatVanBanDiResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataLichSuCapNhatVanBanDiResponseToJson(this);

  DataLichSuCapNhatVanBanDi toModel() => DataLichSuCapNhatVanBanDi(
        messages: messages,
        data: data?.map((e) => e.toModel()).toList() ?? [],
        validationResult: validationResult,
        isSuccess: isSuccess,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LichSuCapNhatVanBanDiResponse extends Equatable {
  @JsonKey(name: 'NguoiCapNhat')
  String? nguoiCapNhat;
  @JsonKey(name: 'DonViCapNhat')
  String? donViCapNhat;
  @JsonKey(name: 'ThoiGian')
  String? thoiGian;
  @JsonKey(name: 'NoiDungCapNhat')
  String? noiDungCapNhat;
  @JsonKey(name: 'TrangThai')
  int? trangThai;
  @JsonKey(name: 'Files')
  List<FilesResponse>? files;

  LichSuCapNhatVanBanDiResponse({
    this.nguoiCapNhat,
    this.donViCapNhat,
    this.thoiGian,
    this.noiDungCapNhat,
    this.trangThai,
    this.files,
  });

  factory LichSuCapNhatVanBanDiResponse.fromJson(Map<String, dynamic> json) =>
      _$LichSuCapNhatVanBanDiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichSuCapNhatVanBanDiResponseToJson(this);

  LichSuCapNhatVanBanDi toModel() => LichSuCapNhatVanBanDi(
        nguoiCapNhat: nguoiCapNhat,
        donViCapNhat: donViCapNhat,
        trangThai: trangThai,
        thoiGian: DateTime.parse(thoiGian ?? '').formatApiLichSu,
        noiDungCapNhat: noiDungCapNhat?.parseHtml(),
        files: files?.map((e) => e.toModel()).toList() ?? [],
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
