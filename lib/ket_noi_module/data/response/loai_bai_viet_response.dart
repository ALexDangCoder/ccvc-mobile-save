import 'package:ccvc_mobile/ket_noi_module/domain/model/loai_bai_viet_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loai_bai_viet_response.g.dart';

@JsonSerializable()
class LoaiBaiVietResponse {
  @JsonKey(name: 'data')
  List<DataLoaiBaiVietResponse>? listData;

  LoaiBaiVietResponse(this.listData);

  factory LoaiBaiVietResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$LoaiBaiVietResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoaiBaiVietResponseToJson(this);

  List<LoaiBaiVietModel> toDomain() =>
      listData?.map((e) => e.toDomain(e.id ?? '')).toList() ?? [];
}

@JsonSerializable()
class DataLoaiBaiVietResponse {
  @JsonKey(name: 'childrens')
  List<DataLoaiBaiVietResponse>? childrens;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'alias')
  String? alias;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'thumbnailUrl')
  String? thumbnailUrl;
  @JsonKey(name: 'parentId')
  String? parentId;
  @JsonKey(name: 'pathItem')
  String? pathItem;
  @JsonKey(name: 'isDuocMoi')
  bool? isDuocMoi;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'order')
  int? order;

  DataLoaiBaiVietResponse();

  factory DataLoaiBaiVietResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DataLoaiBaiVietResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataLoaiBaiVietResponseToJson(this);

  LoaiBaiVietModel toDomain(String ids) => LoaiBaiVietModel(
        childrens: childrens?.map((e) => e.toDomain(ids)).toList() ?? [],
        id: id ?? '',
        title: title ?? '',
        code: code ?? '',
        alias: alias ?? '',
        description: description ?? '',
        thumbnailUrl: thumbnailUrl ?? '',
        parentId: ids,
        pathItem: pathItem ?? '',
        isDuocMoi: isDuocMoi ?? false,
        type: type ?? '',
        order: order ?? 0,
      );
}
