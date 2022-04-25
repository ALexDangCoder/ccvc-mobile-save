import 'package:ccvc_mobile/domain/model/lich_hop/moi_nguoi_tham_gia.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'moi_nguoi_tham_gia_response.g.dart';

@JsonSerializable()
class MoiNguoiThamGiaResponse extends Equatable {
  @JsonKey(name: 'data')
  List<MoiNguoiThamGiaData>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  MoiNguoiThamGiaResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory MoiNguoiThamGiaResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoiNguoiThamGiaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoiNguoiThamGiaResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class MoiNguoiThamGiaData {
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'createAt')
  String? createAt;
  @JsonKey(name: 'dauMoiLienHe')
  String? dauMoiLienHe;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'ghiChu')
  int? ghiChu;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'isThamGiaBocBang')
  bool? isThamGiaBocBang;
  @JsonKey(name: 'v')
  bool? isThuKy;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'tenCanBo')
  String? tenCanBo;
  @JsonKey(name: 'tenCoQuan')
  String? tenCoQuan;
  @JsonKey(name: 'vaiTro')
  int? vaiTro;
  @JsonKey(name: 'vaiTroThamGia')
  int? vaiTroThamGia;

  MoiNguoiThamGiaData({
    required this.canBoId,
    required this.createAt,
    required this.dauMoiLienHe,
    required this.donViId,
    required this.email,
    required this.ghiChu,
    required this.id,
    required this.isThamGiaBocBang,
    required this.isThuKy,
    required this.lichHopId,
    required this.parentId,
    required this.soDienThoai,
    required this.tenCanBo,
    required this.tenCoQuan,
    required this.vaiTro,
    required this.vaiTroThamGia,
  });

  factory MoiNguoiThamGiaData.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MoiNguoiThamGiaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MoiNguoiThamGiaDataToJson(this);

  MoiNguoiThamGiaModel toModel() => MoiNguoiThamGiaModel(
        canBoId: canBoId,
        createAt: createAt,
        dauMoiLienHe: dauMoiLienHe,
        donViId: donViId,
        email: email,
        ghiChu: ghiChu,
        id: id,
        isThamGiaBocBang: isThamGiaBocBang,
        isThuKy: isThuKy,
        lichHopId: lichHopId,
        parentId: parentId,
        soDienThoai: soDienThoai,
        tenCanBo: tenCanBo,
        tenCoQuan: tenCoQuan,
        vaiTro: vaiTro,
        vaiTroThamGia: vaiTroThamGia,
      );
}
