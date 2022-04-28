import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_dang_theo_doi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nguoi_dang_theo_doi_response.g.dart';

@JsonSerializable()
class NguoiDangTheoDoiResponse {
  @JsonKey(name: 'data')
  List<NguoiDangTheoDoiData>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  NguoiDangTheoDoiResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory NguoiDangTheoDoiResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NguoiDangTheoDoiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiDangTheoDoiResponseToJson(this);
}

@JsonSerializable()
class NguoiDangTheoDoiData {
  @JsonKey(name: 'chucVu')
  String? chucVu;
  @JsonKey(name: 'color')
  String? color;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'soBanGhi')
  int? soBanGhi;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'userId')
  String? userId;


  NguoiDangTheoDoiData(this.chucVu, this.color, this.donViId, this.hoTen,
      this.id, this.soBanGhi, this.tenDonVi, this.type, this.userId);

  NguoiDangTheoDoiModel toModel() => NguoiDangTheoDoiModel(
        chucVu: chucVu,
        color: color,
        donViId: donViId,
        hoTen: hoTen,
        id: id,
        soBanGhi: soBanGhi,
        tenDonVi: tenDonVi,
        type: type,
        userId: userId,
      );

  factory NguoiDangTheoDoiData.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$NguoiDangTheoDoiDataFromJson(json);

  Map<String, dynamic> toJson() => _$NguoiDangTheoDoiDataToJson(this);
}
