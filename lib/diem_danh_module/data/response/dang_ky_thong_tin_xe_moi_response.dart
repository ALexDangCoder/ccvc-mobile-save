import 'package:ccvc_mobile/diem_danh_module/domain/model/message_model.dart';
import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dang_ky_thong_tin_xe_moi_response.g.dart';

@JsonSerializable()
class DangKyThongTinXeMoiResponse extends Equatable {
  @JsonKey(name: 'data')
  ThongTinXeMoiResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DangKyThongTinXeMoiResponse(
      {this.statusCode, this.succeeded, this.code, this.message});

  factory DangKyThongTinXeMoiResponse.fromJson(Map<String, dynamic> json) =>
      _$DangKyThongTinXeMoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DangKyThongTinXeMoiResponseToJson(this);

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
class ThongTinXeMoiResponse {
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

  ThongTinXeMoiResponse({
    this.id,
    this.userId,
    this.loaiXeMay,
    this.bienKiemSoat,
    this.loaiSoHuu,
    this.fileId,
  });

  factory ThongTinXeMoiResponse.fromJson(Map<String, dynamic> json) =>
      _$ThongTinXeMoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThongTinXeMoiResponseToJson(this);

  ChiTietBienSoXeModel toModel() => ChiTietBienSoXeModel(
        id: id,
        userId: userId,
        loaiXeMay: loaiXeMay,
        bienKiemSoat: bienKiemSoat,
        loaiSoHuu: loaiSoHuu,
        fileId: fileId,
      );
}
