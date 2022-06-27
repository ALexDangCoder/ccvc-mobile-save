import 'package:ccvc_mobile/diem_danh_module/domain/model/nhan_dien_bien_so_xe/danh_sach_bien_so_xe_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'danh_sach_bien_so_xe_response.g.dart';

@JsonSerializable()
class DataListItemChiTietBienSoXeModelResponse {
  @JsonKey(name: 'data')
  ListItemChiTietBienSoXeModelResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  DataListItemChiTietBienSoXeModelResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory DataListItemChiTietBienSoXeModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DataListItemChiTietBienSoXeModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DataListItemChiTietBienSoXeModelResponseToJson(this);
}

@JsonSerializable()
class ListItemChiTietBienSoXeModelResponse {
  @JsonKey(name: 'items')
  List<ChiTietBienSoXeModelResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  ListItemChiTietBienSoXeModelResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory ListItemChiTietBienSoXeModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ListItemChiTietBienSoXeModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ListItemChiTietBienSoXeModelResponseToJson(this);

  ListItemChiTietBienSoXeModel toModel() => ListItemChiTietBienSoXeModel(
        items: items?.map((e) => e.toModel()).toList(),
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );
}

@JsonSerializable()
class ChiTietBienSoXeModelResponse {
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

  ChiTietBienSoXeModelResponse({
    this.id,
    this.userId,
    this.loaiXeMay,
    this.bienKiemSoat,
    this.loaiSoHuu,
  });

  factory ChiTietBienSoXeModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiTietBienSoXeModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChiTietBienSoXeModelResponseToJson(this);

  ChiTietBienSoXeModel toModel() => ChiTietBienSoXeModel(
        id: id,
        userId: userId,
        loaiXeMay: loaiXeMay,
        bienKiemSoat: bienKiemSoat,
        loaiSoHuu: loaiSoHuu,
      );
}
