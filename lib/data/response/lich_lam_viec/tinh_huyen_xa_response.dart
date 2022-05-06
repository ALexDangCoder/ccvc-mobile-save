import 'package:ccvc_mobile/domain/model/lich_hop/tinh_huyen_xa_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tinh_huyen_xa_response.g.dart';

//////////tinh
@JsonSerializable()
class PageDaTaTinhSelectModelResponse extends Equatable {
  @JsonKey(name: 'data')
  DaTaTinhSelectModelResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  PageDaTaTinhSelectModelResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory PageDaTaTinhSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PageDaTaTinhSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PageDaTaTinhSelectModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DaTaTinhSelectModelResponse extends Equatable {
  @JsonKey(name: 'items')
  List<TinhSelectModelResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DaTaTinhSelectModelResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory DaTaTinhSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DaTaTinhSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DaTaTinhSelectModelResponseToJson(this);

  DaTaTinhSelectModel toModel() => DaTaTinhSelectModel(
        items: items?.map((e) => e.toModel()).toList(),
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class TinhSelectModelResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'ma')
  String? ma;
  @JsonKey(name: 'tenTinhThanh')
  String? tenTinhThanh;
  @JsonKey(name: 'totalItems')
  int? totalItems;

  TinhSelectModelResponse({
    this.id,
    this.ma,
    this.tenTinhThanh,
    this.totalItems,
  });

  factory TinhSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$TinhSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TinhSelectModelResponseToJson(this);

  TinhSelectModel toModel() => TinhSelectModel(
        id: id,
        ma: ma,
        tenTinhThanh: tenTinhThanh,
        totalItems: totalItems,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

//////////// huyen
@JsonSerializable()
class PageDaTaHuyenSelectModelResponse extends Equatable {
  @JsonKey(name: 'data')
  DaTaHuyenSelectModelResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  PageDaTaHuyenSelectModelResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory PageDaTaHuyenSelectModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PageDaTaHuyenSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PageDaTaHuyenSelectModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DaTaHuyenSelectModelResponse extends Equatable {
  @JsonKey(name: 'items')
  List<HuyenSelectModelResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DaTaHuyenSelectModelResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory DaTaHuyenSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DaTaHuyenSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DaTaHuyenSelectModelResponseToJson(this);

  DaTaHuyenSelectModel toModel() => DaTaHuyenSelectModel(
        items: items?.map((e) => e.toModel()).toList(),
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class HuyenSelectModelResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'tinhId')
  String? tinhId;
  @JsonKey(name: 'ma')
  String? ma;
  @JsonKey(name: 'tenQuanHuyen')
  String? tenQuanHuyen;
  @JsonKey(name: 'totalItems')
  int? totalItems;

  HuyenSelectModelResponse({
    this.id,
    this.tinhId,
    this.ma,
    this.tenQuanHuyen,
    this.totalItems,
  });

  factory HuyenSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$HuyenSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HuyenSelectModelResponseToJson(this);

  HuyenSelectModel toModel() => HuyenSelectModel(
        id: id,
        tinhId: tinhId,
        ma: ma,
        tenQuanHuyen: tenQuanHuyen,
        totalItems: totalItems,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

///////////xa
@JsonSerializable()
class PageDaTaXaSelectModelResponse extends Equatable {
  @JsonKey(name: 'data')
  DaTaXaSelectModelResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  PageDaTaXaSelectModelResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory PageDaTaXaSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$PageDaTaXaSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageDaTaXaSelectModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DaTaXaSelectModelResponse extends Equatable {
  @JsonKey(name: 'items')
  List<XaSelectModelResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DaTaXaSelectModelResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory DaTaXaSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DaTaXaSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DaTaXaSelectModelResponseToJson(this);

  DaTaXaSelectModel toModel() => DaTaXaSelectModel(
        items: items?.map((e) => e.toModel()).toList(),
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class XaSelectModelResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'huyenId')
  String? huyenId;
  @JsonKey(name: 'ma')
  String? ma;
  @JsonKey(name: 'tenXaPhuong')
  String? tenXaPhuong;
  @JsonKey(name: 'totalItems')
  int? totalItems;

  XaSelectModelResponse({
    this.id,
    this.huyenId,
    this.ma,
    this.tenXaPhuong,
    this.totalItems,
  });

  factory XaSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$XaSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$XaSelectModelResponseToJson(this);

  XaSelectModel toModel() => XaSelectModel(
        id: id,
        huyenId: huyenId,
        ma: ma,
        tenXaPhuong: tenXaPhuong,
        totalItems: totalItems,
      );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

//datNuoc model
@JsonSerializable()
class PageDataDatNuocSelectModelResponse extends Equatable {
  @JsonKey(name: 'data')
  DataDatNuocSelectModelResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  PageDataDatNuocSelectModelResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  factory PageDataDatNuocSelectModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PageDataDatNuocSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PageDataDatNuocSelectModelResponseToJson(this);

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataDatNuocSelectModelResponse extends Equatable {
  @JsonKey(name: 'items')
  List<DatNuocSelectModelResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  DataDatNuocSelectModelResponse({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  factory DataDatNuocSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DataDatNuocSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataDatNuocSelectModelResponseToJson(this);

  DataDatNuocSelectModel toModel() => DataDatNuocSelectModel(
    items:items?.map((e) => e.toModel()).toList(),
    pageIndex:pageIndex,
    pageSize:pageSize,
    totalCount:totalCount,
    totalPage:totalPage,
  );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DatNuocSelectModelResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'totalItems')
  int? totalItems;

  DatNuocSelectModelResponse({
    this.id,
    this.name,
    this.totalItems,
  });

  factory DatNuocSelectModelResponse.fromJson(Map<String, dynamic> json) =>
      _$DatNuocSelectModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DatNuocSelectModelResponseToJson(this);
  DatNuocSelectModel toModel()=>DatNuocSelectModel(
    id:id,
    name:name,
    totalItems:totalItems,
  );

  //todo convert to Model to use
  @override
  List<Object?> get props => [];
}
