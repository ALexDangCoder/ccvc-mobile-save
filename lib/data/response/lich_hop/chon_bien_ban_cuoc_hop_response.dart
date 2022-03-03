import 'package:ccvc_mobile/domain/model/lich_hop/chon_bien_ban_cuoc_hop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chon_bien_ban_cuoc_hop_response.g.dart';

@JsonSerializable()
class ChonBienBanCuocHopResponse {
  @JsonKey(name: 'data')
  DataChonBienBanCuocHopResponse data;

  ChonBienBanCuocHopResponse(this.data);

  factory ChonBienBanCuocHopResponse.fromJson(Map<String, dynamic> json) =>
      _$ChonBienBanCuocHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChonBienBanCuocHopResponseToJson(this);
}

@JsonSerializable()
class DataChonBienBanCuocHopResponse {
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

  DataChonBienBanCuocHopResponse(
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  );

  factory DataChonBienBanCuocHopResponse.fromJson(Map<String, dynamic> json) =>
      _$DataChonBienBanCuocHopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataChonBienBanCuocHopResponseToJson(this);

  ChonBienBanCuocHopModel toDomain() => ChonBienBanCuocHopModel(
        items: items?.map((e) => e.toModel()).toList() ?? [],
        pageIndex: pageIndex,
        pageSize: pageSize,
        totalCount: totalCount,
        totalPage: totalPage,
      );
}

@JsonSerializable()
class ItemsResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'totalItems')
  int? totalItems;
  @JsonKey(name: 'isXoa')
  bool? isXoa;

  ItemsResponse(
      {this.id, this.name, this.content, this.totalItems, this.isXoa});

  factory ItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsResponseToJson(this);

  ItemsModel toModel() => ItemsModel(
        id: id,
        name: name,
        content: content,
        totalItems: totalItems,
        isXoa: isXoa,
      );
}
