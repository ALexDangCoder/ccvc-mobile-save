import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cap_nhat_bien_so_xe_response.g.dart';

@JsonSerializable()
class DataCapNhatBienSoXeResponse extends Equatable {
  @JsonKey(name: 'data')
  CapNhatBienSoXeResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DataCapNhatBienSoXeResponse(
      {this.statusCode, this.succeeded, this.code, this.message});

  factory DataCapNhatBienSoXeResponse.fromJson(Map<String, dynamic> json) =>
      _$DataCapNhatBienSoXeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataCapNhatBienSoXeResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
  DataResponseTaoChiTietBienSoXeModel toDomain()=>DataResponseTaoChiTietBienSoXeModel(
    code: code,
    data: data?.toModel(),
    message: message,
    statusCode: statusCode,
    succeeded: succeeded,
  );
}

@JsonSerializable()
class CapNhatBienSoXeResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'loaiXeMay')
  String? loaiXeMay;
  @JsonKey(name: 'bienKiemSoat')
  String? bienKiemSoat;
  @JsonKey(name: 'loaiSoHuu')
  String? loaiSoHuu;
  @JsonKey(name: 'fileId')
  String? fileId;

  CapNhatBienSoXeResponse({
    this.id,
    this.userId,
    this.loaiXeMay,
    this.bienKiemSoat,
    this.loaiSoHuu,
    this.fileId,
  });

  factory CapNhatBienSoXeResponse.fromJson(Map<String, dynamic> json) =>
      _$CapNhatBienSoXeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CapNhatBienSoXeResponseToJson(this);

  ChiTietBienSoXeModel toModel() => ChiTietBienSoXeModel(
        id: id,
        userId: userId,
        loaiXeMay: loaiXeMay,
        bienKiemSoat: bienKiemSoat,
        loaiSoHuu: loaiSoHuu,
        fileId: fileId,
      );
}
