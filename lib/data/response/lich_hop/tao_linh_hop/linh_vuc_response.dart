import 'package:ccvc_mobile/domain/model/tao_lich_hop/linh_vuc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'linh_vuc_response.g.dart';

@JsonSerializable()
class DashBoardLichHopResponse extends Equatable {
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

  DashBoardLichHopResponse(
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  );

  factory DashBoardLichHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DashBoardLichHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashBoardLichHopResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LinhVucDataResponse extends Equatable {
  List<ItemLinhVucResponse>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  LinhVucDataResponse({
    required this.items,
    required this.pageIndex,
    required this.pageSize,
    required this.totalCount,
    required this.totalPage,
  });

  LinhVucModel toModel() =>

  factory LinhVucDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LinhVucDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LinhVucDataResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemLinhVucResponse extends Equatable {
  String? id;
  String? name;
  String? code;
  int? totalItems;

  ItemLinhVucResponse({
    required this.id,
    required this.name,
    required this.code,
    required this.totalItems,
  });

  ItemLinhVucResponse toModel() => ItemLinhVucResponse(
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
