import 'package:ccvc_mobile/tien_ich_module/presentation/danh_ba_dien_tu/ui/mobile/tree/model/TreeModel.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tree_danh_ba_response.g.dart';

@JsonSerializable()
class TreeDanhBaResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DataTreeDanhBaResponse>? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  TreeDanhBaResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory TreeDanhBaResponse.fromJson(Map<String, dynamic> json) =>
      _$TreeDanhBaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TreeDanhBaResponseToJson(this);

  List<TreeDonViDanhBA> toModel() =>
      data?.map((e) => e.toModel()).toList() ?? [];

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataTreeDanhBaResponse extends Equatable {
  @JsonKey(name: 'bitDauMoiPAKN')
  bool? bitDauMoiPAKN;
  @JsonKey(name: 'bit_DonViBoPhan')
  bool? bit_DonViBoPhan;
  @JsonKey(name: 'bit_DonViSuNghiep')
  bool? bit_DonViSuNghiep;
  @JsonKey(name: 'bit_DonViThuocBo')
  bool? bit_DonViThuocBo;
  @JsonKey(name: 'bit_KieuDonVi')
  dynamic? bit_KieuDonVi;
  @JsonKey(name: 'bit_TrangThaiDonVi')
  dynamic? bit_TrangThaiDonVi;
  @JsonKey(name: 'capDonVi')
  int? capDonVi;
  @JsonKey(name: 'duongDan_ID_DonVi')
  String? duongDan_ID_DonVi;
  @JsonKey(name: 'duongDan_ID_DonVi_Cha')
  String? duongDan_ID_DonVi_Cha;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'fax')
  dynamic? fax;
  @JsonKey(name: 'hasDonViCon')
  bool? hasDonViCon;
  @JsonKey(name: 'iD_DonVi_Cha')
  String? iD_DonVi_Cha;
  @JsonKey(name: 'iD_DonVi_Goc')
  String? iD_DonVi_Goc;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'level')
  int? level;
  @JsonKey(name: 'maDonVi')
  String? maDonVi;
  @JsonKey(name: 'maLienThong')
  dynamic? maLienThong;
  @JsonKey(name: 'soDienThoai')
  dynamic? soDienThoai;
  @JsonKey(name: 'tenDonVi')
  String? tenDonVi;
  @JsonKey(name: 'tenDonViCha')
  String? tenDonViCha;
  @JsonKey(name: 'tenDonViGoc')
  String? tenDonViGoc;
  @JsonKey(name: 'thuTu')
  int? thuTu;

  DataTreeDanhBaResponse({
    this.bitDauMoiPAKN,
    this.bit_DonViBoPhan,
    this.bit_DonViSuNghiep,
    this.bit_DonViThuocBo,
    this.bit_KieuDonVi,
    this.bit_TrangThaiDonVi,
    this.capDonVi,
    this.duongDan_ID_DonVi,
    this.duongDan_ID_DonVi_Cha,
    this.email,
    this.fax,
    this.hasDonViCon,
    this.iD_DonVi_Cha,
    this.iD_DonVi_Goc,
    this.id,
    this.level,
    this.maDonVi,
    this.maLienThong,
    this.soDienThoai,
    this.tenDonVi,
    this.tenDonViCha,
    this.tenDonViGoc,
    this.thuTu,
  });

  TreeDonViDanhBA toModel() => TreeDonViDanhBA(
        bitDauMoiPAKN: bitDauMoiPAKN ?? false,
        bit_DonViBoPhan: bit_DonViBoPhan ?? false,
        bit_DonViSuNghiep: bit_DonViSuNghiep ?? false,
        bit_DonViThuocBo: bit_DonViThuocBo ?? false,
        bit_KieuDonVi: bit_KieuDonVi,
        bit_TrangThaiDonVi: bit_TrangThaiDonVi,
        capDonVi: capDonVi ?? 0,
        duongDan_ID_DonVi: duongDan_ID_DonVi ?? '',
        duongDan_ID_DonVi_Cha: duongDan_ID_DonVi_Cha ?? '',
        email: email ?? '',
        fax: fax,
        hasDonViCon: hasDonViCon ?? false,
        iDDonViCha: iD_DonVi_Cha ?? '',
        iD_DonVi_Goc: iD_DonVi_Goc ?? '',
        id: id ?? '',
        level: level ?? 0,
        maDonVi: maDonVi ?? '',
        maLienThong: maLienThong,
        soDienThoai: soDienThoai,
        tenDonVi: tenDonVi ?? '',
        tenDonViCha: tenDonViCha ?? '',
        tenDonViGoc: tenDonViGoc ?? '',
        thuTu: thuTu ?? 0,
      );

  factory DataTreeDanhBaResponse.fromJson(Map<String, dynamic> json) =>
      _$DataTreeDanhBaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTreeDanhBaResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
