import 'package:ccvc_mobile/domain/model/detail_doccument/lich_su_van_ban_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lich_su_van_ban_response.g.dart';

@JsonSerializable()
class DataLichSuVanBanResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<LichSuVanBanResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  DataLichSuVanBanResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory DataLichSuVanBanResponse.fromJson(Map<String, dynamic> json) =>
      _$DataLichSuVanBanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataLichSuVanBanResponseToJson(this);

  DataLichSuVanBanModel toModel() => DataLichSuVanBanModel(
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
class LichSuVanBanResponse extends Equatable {
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

  LichSuVanBanResponse({
    this.nguoiTaoXuLy,
    this.donViTaoXuLy,
    this.thoiGianTao,
    this.noiDung,
    this.nguoiXuLy,
    this.donViXuLy,
    this.fileDinhKems,
    this.hoatDong,
  });

  factory LichSuVanBanResponse.fromJson(Map<String, dynamic> json) =>
      _$LichSuVanBanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LichSuVanBanResponseToJson(this);

  LichSuVanBanModel toModel() => LichSuVanBanModel(
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

@JsonSerializable()
class FileDinhKemsResponse extends Equatable {
  @JsonKey(name: 'Id')
  String? id;
  @JsonKey(name: 'IdFileGoc')
  String? idFileGoc;
  @JsonKey(name: 'ProcessId')
  String? processId;
  @JsonKey(name: 'Ten')
  String? ten;
  @JsonKey(name: 'DuongDan')
  String? duongDan;
  @JsonKey(name: 'DuoiMoRong')
  String? duoiMoRong;
  @JsonKey(name: 'DungLuong')
  String? dungLuong;
  @JsonKey(name: 'KieuDinhKem')
  String? kieuDinhKem;
  @JsonKey(name: 'IsSign')
  bool? isSign;
  @JsonKey(name: 'QrCreated')
  String? qrCreated;
  @JsonKey(name: 'Index')
  int? index;
  @JsonKey(name: 'NguoiTaoId')
  String? nguoiTaoId;
  @JsonKey(name: 'NguoiTao')
  String? nguoiTao;
  @JsonKey(name: 'PathIOC')
  String? pathIOC;

  FileDinhKemsResponse({
    this.id,
    this.idFileGoc,
    this.processId,
    this.ten,
    this.duongDan,
    this.duoiMoRong,
    this.dungLuong,
    this.kieuDinhKem,
    this.isSign,
    this.qrCreated,
    this.index,
    this.nguoiTaoId,
    this.nguoiTao,
    this.pathIOC,
  });

  factory FileDinhKemsResponse.fromJson(Map<String, dynamic> json) =>
      _$FileDinhKemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileDinhKemsResponseToJson(this);

  FileDinhKems toModel() => FileDinhKems(
        id: id,
        idFileGoc: idFileGoc,
        processId: processId,
        ten: ten,
        duongDan: duongDan,
        duoiMoRong: duoiMoRong,
        dungLuong: dungLuong,
        kieuDinhKem: kieuDinhKem,
        isSign: isSign,
        qrCreated: qrCreated,
        index: index,
        nguoiTaoId: nguoiTaoId,
        nguoiTao: nguoiTao,
        pathIOC: pathIOC,
      );

  @override
  List<Object?> get props => [];
}
