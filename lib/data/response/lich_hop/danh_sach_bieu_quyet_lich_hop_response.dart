import 'package:ccvc_mobile/domain/model/lich_hop/danh_sach_bieu_quyet_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_bieu_quyet_lich_hop_response.g.dart';

@JsonSerializable()
class DanhSachBieuQuyetLichHopDataResponse {
  @JsonKey(name: 'data')
  List<DanhSachBieuQuyetLichHopResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DanhSachBieuQuyetLichHopDataResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DanhSachBieuQuyetLichHopDataResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachBieuQuyetLichHopDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachBieuQuyetLichHopDataResponseToJson(this);

  List<DanhSachBietQuyetModel> toModel() =>
      data?.map((e) => e.toModel()).toList() ?? [];
}

@JsonSerializable()
class DanhSachBieuQuyetLichHopResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'idLichHop')
  String? idLichHop;
  @JsonKey(name: 'idPhienHopCanBo')
  String? idPhienHopCanBo;
  @JsonKey(name: 'noiDung')
  String? noiDung;
  @JsonKey(name: 'thoiGianBatDau')
  String? thoiGianBatDau;
  @JsonKey(name: 'thoiGianKetThuc')
  String? thoiGianKetThuc;
  @JsonKey(name: 'loaiBieuQuyet')
  bool? loaiBieuQuyet;
  @JsonKey(name: 'danhSachKetQuaBieuQuyet')
  List<DanhSachKetQuaBieuQuyetResponse>? danhSachKetQuaBieuQuyet;

  DanhSachBieuQuyetLichHopResponse(
    this.id,
    this.idLichHop,
    this.idPhienHopCanBo,
    this.noiDung,
    this.thoiGianBatDau,
    this.thoiGianKetThuc,
    this.loaiBieuQuyet,
    this.danhSachKetQuaBieuQuyet,
  );

  factory DanhSachBieuQuyetLichHopResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachBieuQuyetLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachBieuQuyetLichHopResponseToJson(this);

  DanhSachBietQuyetModel toModel() => DanhSachBietQuyetModel(
        id: id,
        idLichHop: idLichHop,
        idPhienHopCanBo: idPhienHopCanBo,
        noiDung: noiDung,
        thoiGianBatDau: thoiGianBatDau,
        thoiGianKetThuc: thoiGianKetThuc,
        loaiBieuQuyet: loaiBieuQuyet,
        danhSachKetQuaBieuQuyet: danhSachKetQuaBieuQuyet
                ?.map(
                  (e) => e.toModel(),
                )
                .toList() ??
            [],
      );
}

@JsonSerializable()
class DanhSachKetQuaBieuQuyetResponse {
  @JsonKey(name: 'luaChonId')
  String? luaChonId;
  @JsonKey(name: 'tenLuaChon')
  String? tenLuaChon;
  @JsonKey(name: 'mauLuaChon')
  String? mauLuaChon;
  @JsonKey(name: 'soLuongLuaChon')
  int? soLuongLuaChon;
  @JsonKey(name: 'isVote')
  bool? isVote;

  DanhSachKetQuaBieuQuyetResponse({
    this.luaChonId,
    this.tenLuaChon,
    this.mauLuaChon,
    this.soLuongLuaChon,
    this.isVote,
  });

  factory DanhSachKetQuaBieuQuyetResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DanhSachKetQuaBieuQuyetResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DanhSachKetQuaBieuQuyetResponseToJson(this);

  DanhSachKetQuaBieuQuyet toModel() => DanhSachKetQuaBieuQuyet(
        luaChonId: luaChonId,
        tenLuaChon: tenLuaChon,
        mauLuaChon: mauLuaChon,
        soLuongLuaChon: soLuongLuaChon,
        isVote: isVote,
      );
}
