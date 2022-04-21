import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thanh_phan_tham_gia_response.g.dart';

@JsonSerializable()
class ThanhPhanThamGiaResponse extends Equatable {
  @JsonKey(name: 'data')
  List<ThanhPhanThamGiaData>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ThanhPhanThamGiaResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory ThanhPhanThamGiaResponse.fromJson(Map<String, dynamic> json) =>
      _$ThanhPhanThamGiaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ThanhPhanThamGiaResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ThanhPhanThamGiaData extends Equatable {
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'createAt')
  String? createAt;
  @JsonKey(name: 'dauMoiLienHe')
  int? dauMoiLienHe;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'ghiChu')
  String? ghiChu;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'isThamGiaBocBang')
  bool? isThamGiaBocBang;
  @JsonKey(name: 'isThuKy')
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
  String? vaiTro;
  @JsonKey(name: 'vaiTroThamGia')
  int? vaiTroThamGia;


  ThanhPhanThamGiaData(
      {required this.canBoId,
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
        required this.vaiTroThamGia,});

  ThanhPhanThamGiaData.empty();

  factory ThanhPhanThamGiaData.fromJson(Map<String, dynamic> json) =>
      _$ThanhPhanThamGiaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ThanhPhanThamGiaDataToJson(this);

  CanBoModel toModel() =>
      CanBoModel(
          id: id,
          lichHopId: lichHopId,
          donViId: donViId,
          canBoId: canBoId,
          vaiTro: vaiTro,
          tenCanBo: tenCanBo,
          ghiChu: ghiChu,
          parentId: parentId,
          vaiTroThamGia: vaiTroThamGia,
          email: email,
          soDienThoai: soDienThoai,
          tenCoQuan: tenCoQuan,
          isThuKy: isThuKy,
          isThamGiaBocBang: isThamGiaBocBang,
          createAt: createAt,);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
