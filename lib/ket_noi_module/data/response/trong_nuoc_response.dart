import 'package:ccvc_mobile/ket_noi_module/domain/model/trong_nuoc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trong_nuoc_response.g.dart';

@JsonSerializable()
class TrongNuocResponse {
  @JsonKey(name: 'data')
  DataTrongNuocResponse data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  TrongNuocResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory TrongNuocResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TrongNuocResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrongNuocResponseToJson(this);
}

@JsonSerializable()
class DataTrongNuocResponse {
  @JsonKey(name: 'hasNextPage')
  bool? hasNextPage;
  @JsonKey(name: 'hasPreviousPage')
  bool? hasPreviousPage;
  @JsonKey(name: 'pageData')
  List<ItemTrongNuocResponse>? pageData;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'totalIndex')
  int? totalIndex;
  @JsonKey(name: 'totalItems')
  int? totalItems;
  @JsonKey(name: 'totalPages')
  int? totalPages;

  DataTrongNuocResponse(
      {required this.hasNextPage,
      required this.hasPreviousPage,
      required this.pageData,
      required this.pageIndex,
      required this.totalIndex,
      required this.totalItems,
      required this.totalPages});

  factory DataTrongNuocResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataTrongNuocResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataTrongNuocResponseToJson(this);

  TrongNuocModel toModel() => TrongNuocModel(
        hasNextPage: hasNextPage,
        hasPreviousPage: hasPreviousPage,
        pageData: pageData?.map((e) => e.toModel()).toList() ?? [],
        pageIndex: pageIndex,
        totalIndex: totalIndex,
        totalItems: totalItems,
        totalPages: totalPages,
      );
}

@JsonSerializable()
class ItemTrongNuocResponse {
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'categoryTitle')
  String? categoryTitle;
  @JsonKey(name: 'diaChi')
  String? diaChi;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'fax')
  String? fax;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'imageUrlPath')
  String? imageUrlPath;
  @JsonKey(name: 'sdt')
  String? sdt;
  @JsonKey(name: 'tenCoQuanLienHe')
  String? tenCoQuanLienHe;

  ItemTrongNuocResponse(
      {required this.category,
      required this.categoryTitle,
      required this.diaChi,
      required this.email,
      required this.fax,
      required this.id,
      required this.imageUrlPath,
      required this.sdt,
      required this.tenCoQuanLienHe});

  factory ItemTrongNuocResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ItemTrongNuocResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemTrongNuocResponseToJson(this);

  ItemTrongNuocModel toModel() => ItemTrongNuocModel(
        category: category,
        categoryTitle: categoryTitle,
        diaChi: diaChi,
        email: email,
        fax: fax,
        id: id,
        imageUrlPath: imageUrlPath,
        sdt: sdt,
        tenCoQuanLienHe: tenCoQuanLienHe,
      );
}
