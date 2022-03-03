import 'package:ccvc_mobile/data/response/lich_hop/danh_sach_can_bo_response.dart';
import 'package:ccvc_mobile/domain/model/lich_hop/chuong_trinh_hop.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chuong_trinh_hop_response.g.dart';

@JsonSerializable()
class ChuongTrinhHopResponse extends Equatable {
  @JsonKey(name: 'data')
  ChuongTrinhHopDataResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  ChuongTrinhHopResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory ChuongTrinhHopResponse.fromJson(Map<String, dynamic> json) =>
      _$ChuongTrinhHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChuongTrinhHopResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ChuongTrinhHopDataResponse extends Equatable {
  List<CanBoItemResponse>? listCanBo;
  CountStatusResponse? countStatus;

  ChuongTrinhHopDataResponse(
      {required this.listCanBo, required this.countStatus});

  ChuongTrinhHopModel toModel() => ChuongTrinhHopModel(
        listCanBo: listCanBo?.map((e) => e.toModel()).toList() ?? [],
        countStatus: countStatus?.toModel(),
      );

  factory ChuongTrinhHopDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ChuongTrinhHopDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChuongTrinhHopDataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class CanBoItemResponse extends Equatable {
  @JsonKey(name: 'tenChucVu')
  String? tenChucVu;
  @JsonKey(name: 'diemDanh')
  bool? diemDanh;
  @JsonKey(name: 'disable')
  bool? disable;
  @JsonKey(name: 'trangThai')
  int? trangThai;
  @JsonKey(name: 'isVangMat')
  bool? isVangMat;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'lichHopId')
  String? lichHopId;
  @JsonKey(name: 'donViId')
  String? donViId;
  @JsonKey(name: 'canBoId')
  String? canBoId;
  @JsonKey(name: 'vaiTro')
  String? vaiTro;
  @JsonKey(name: 'ghiChu')
  String? ghiChu;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'vaiTroThamGia')
  int? vaiTroThamGia;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'soDienThoai')
  String? soDienThoai;
  @JsonKey(name: 'dauMoiLienHe')
  String? dauMoiLienHe;
  @JsonKey(name: 'tenCoQuan')
  String? tenCoQuan;
  @JsonKey(name: 'isThuKy')
  bool? isThuKy;
  @JsonKey(name: 'isThamGiaBocBang')
  bool? isThamGiaBocBang;
  @JsonKey(name: 'createAt')
  String? createAt;
  @JsonKey(name: 'tenCanBo')
  String? tenCanBo;

  CanBoModel toModel() => CanBoModel(
        tenCanBo: tenCanBo,
        tenChucVu: tenChucVu,
        diemDanh: diemDanh,
        disable: disable,
        trangThai: trangThai,
        isVangMat: isVangMat,
        id: id,
        lichHopId: lichHopId,
        donViId: donViId,
        canBoId: canBoId,
        vaiTro: vaiTro,
        ghiChu: ghiChu,
        parentId: parentId,
        vaiTroThamGia: vaiTroThamGia,
        email: email,
        soDienThoai: soDienThoai,
        dauMoiLienHe: dauMoiLienHe,
        tenCoQuan: tenCoQuan,
        isThuKy: isThuKy,
        isThamGiaBocBang: isThamGiaBocBang,
        createAt: createAt,
      );

  CanBoItemResponse({
    required this.tenChucVu,
    required this.diemDanh,
    required this.disable,
    required this.trangThai,
    required this.isVangMat,
    required this.id,
    required this.lichHopId,
    required this.donViId,
    required this.canBoId,
    required this.vaiTro,
    required this.ghiChu,
    required this.parentId,
    required this.vaiTroThamGia,
    required this.email,
    required this.soDienThoai,
    required this.dauMoiLienHe,
    required this.tenCoQuan,
    required this.isThuKy,
    required this.isThamGiaBocBang,
    required this.createAt,
  });

  factory CanBoItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CanBoItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CanBoItemResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class CountStatusResponse {
  @JsonKey(name: 'tongSoThamGia')
  int? tongSoThamGia;
  @JsonKey(name: 'tongSoTuChoi')
  int? tongSoTuChoi;
  @JsonKey(name: 'daDiemDanh')
  int? daDiemDanh;
  @JsonKey(name: 'chuaDiemDanh')
  int? chuaDiemDanh;

  CountStatusResponse({
    this.tongSoThamGia,
    this.tongSoTuChoi,
    this.daDiemDanh,
    this.chuaDiemDanh,
  });

  CountStatus toModel() => CountStatus(
        chuaDiemDanh: chuaDiemDanh,
        daDiemDanh: daDiemDanh,
        tongSoThamGia: tongSoThamGia,
        tongSoTuChoi: tongSoThamGia,
      );

  factory CountStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$CountStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountStatusResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
