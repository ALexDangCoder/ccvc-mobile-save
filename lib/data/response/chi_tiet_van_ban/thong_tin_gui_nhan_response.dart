import 'package:ccvc_mobile/domain/model/detail_doccument/thong_tin_gui_nhan.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thong_tin_gui_nhan_response.g.dart';

@JsonSerializable()
class ThongTinGuiNhanDataResponse extends Equatable {
  @JsonKey(name: 'Messages')
  String? messages;
  @JsonKey(name: 'Data')
  List<ThongTinGuiNhanResponse>? data;
  @JsonKey(name: 'ValidationResult')
  String? validationResult;
  @JsonKey(name: 'IsSuccess')
  bool? isSuccess;

  ThongTinGuiNhanDataResponse({
    this.messages,
    this.data,
    this.validationResult,
    this.isSuccess,
  });

  factory ThongTinGuiNhanDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongTinGuiNhanDataResponseFromJson(json);

  DataThongTinGuiNhanModel toModel() => DataThongTinGuiNhanModel(
        messages: messages,
        data: data?.map((e) => e.toModel()).toList() ?? [],
        validationResult: validationResult,
        isSuccess: isSuccess,
      );

  Map<String, dynamic> toJson() => _$ThongTinGuiNhanDataResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ThongTinGuiNhanResponse extends Equatable {
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
  @JsonKey(name: 'MaTrangThai')
  String? maTrangThai;

  ThongTinGuiNhanResponse({
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
    this.maTrangThai,
  });

  factory ThongTinGuiNhanResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongTinGuiNhanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinGuiNhanResponseToJson(this);

  ThongTinGuiNhanModel toModel() => ThongTinGuiNhanModel(
        nguoiGui: nguoiGui,
        donViGui: donViGui,
        donViNhan: donViNhan,
        trangThai: trangThai,
        nguoiNhan: nguoiNhan,
        thoiGian: thoiGian,
        vaiTroXuLy: vaiTroXuLy,
        maTrangThai: maTrangThai,
      );

  @override
  List<Object?> get props => [];
}
