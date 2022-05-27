import 'package:ccvc_mobile/tien_ich_module/domain/model/danh_ba_dien_tu.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_ba_dien_tu_response.g.dart';

@JsonSerializable()
class DanhBaResponse extends Equatable {
  @JsonKey(name: 'data')
  DataDanhBaResponse? data;

  DanhBaResponse({
    this.data,
  });

  factory DanhBaResponse.fromJson(Map<String, dynamic> json) =>
      _$DanhBaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DanhBaResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class DataDanhBaResponse {
  @JsonKey(name: 'items')
  List<ItemsResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DataDanhBaResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory DataDanhBaResponse.fromJson(Map<String, dynamic> json) =>
      _$DataDanhBaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataDanhBaResponseToJson(this);

  DanhBaDienTuModel toDomain() => DanhBaDienTuModel(
        items: items?.map((e) => e.toDomain()).toList() ?? [],
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );
}

@JsonSerializable()
class ItemsResponse {
  @JsonKey(name: 'groups')
  String? groups;
  @JsonKey(name: 'hoTen')
  String? hoTen;
  @JsonKey(name: 'phone_DiDong')
  String? phoneDiDong;
  @JsonKey(name: 'phone_CoQuan')
  String? phoneCoQuan;
  @JsonKey(name: 'phone_NhaRieng')
  String? phoneNhaRieng;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'gioiTinh')
  bool? gioiTinh;
  @JsonKey(name: 'ngaySinh')
  String? ngaySinh;
  @JsonKey(name: 'cmtnd')
  String? cmtnd;
  @JsonKey(name: 'anhDaiDien_FilePath')
  String? anhDaiDienFilePath;
  @JsonKey(name: 'anhChuKy_FilePath')
  String? anhChuKyFilePath;
  @JsonKey(name: 'anhChuKyNhay_FilePath')
  String? anhChuKyNhayFilePath;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'thuTu')
  int? thuTu;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'updatedBy')
  String? updatedBy;
  @JsonKey(name: 'id')
  String? id;

  ItemsResponse({
    this.groups,
    this.hoTen,
    this.phoneDiDong,
    this.phoneCoQuan,
    this.phoneNhaRieng,
    this.email,
    this.gioiTinh,
    this.ngaySinh,
    this.cmtnd,
    this.anhDaiDienFilePath,
    this.anhChuKyFilePath,
    this.anhChuKyNhayFilePath,
    this.diaChi,
    this.isDeleted,
    this.thuTu,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.id,
  });

  factory ItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsResponseToJson(this);

  Items toDomain() {
    return Items(
      groups: groups,
      hoTen: hoTen,
      phoneDiDong: phoneDiDong,
      phoneCoQuan: phoneCoQuan,
      phoneNhaRieng: phoneNhaRieng,
      email: email,
      gioiTinh: gioiTinh,
      ngaySinh: ngaySinh,
      cmtnd: cmtnd,
      anhDaiDienFilePath: anhDaiDienFilePath,
      anhChuKyFilePath: anhChuKyFilePath,
      anhChuKyNhayFilePath: anhChuKyNhayFilePath,
      diaChi: diaChi,
      isDeleted: isDeleted,
      thuTu: thuTu,
      createdAt: createdAt,
      createdBy: createdBy,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      id: id,
    );
  }
}
