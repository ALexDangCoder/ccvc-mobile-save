import 'package:ccvc_mobile/domain/model/tao_lich_hop/linh_vuc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'linh_vuc_response.g.dart';

@JsonSerializable()
class LinhVucResponse extends Equatable {
  @JsonKey(name: 'data')
  LinhVucDataResponse? data;
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'message')
  String? message;

  LinhVucResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory LinhVucResponse.fromJson(Map<String, dynamic> json) =>
      _$LinhVucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LinhVucResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LinhVucDataResponse extends Equatable {
  @JsonKey(name: 'items')
  List<ItemLinhVucResponse>? items;
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'pageSize')
  int? pageSize;
  @JsonKey(name: 'totalCount')
  int? totalCount;
  @JsonKey(name: 'totalPage')
  int? totalPage;

  LinhVucDataResponse({
    required this.items,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });

  LinhVucModel toModel() => LinhVucModel(
        items: items?.map((e) => e.toModel()).toList() ?? [],
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );

  factory LinhVucDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LinhVucDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LinhVucDataResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemLinhVucResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'totalItems')
  int? totalItems;

  ItemLinhVucResponse({
    required this.id,
    required this.name,
    required this.code,
    required this.totalItems,
  });

  ItemLinhVucModel toModel() => ItemLinhVucModel(
        id: id,
        name: name,
        code: code,
        totalItems: totalItems,
      );

  factory ItemLinhVucResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemLinhVucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemLinhVucResponseToJson(this);

  @override
  List<Object?> get props => [];
}
