import 'dart:core';

import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/tin_tuc_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_tin_tuc_response.g.dart';

@JsonSerializable()
class SearchTinTucResponse {
  @JsonKey(name: 'pageIndex')
  int? pageIndex;
  @JsonKey(name: 'totalItems')
  int? totalItems;
  @JsonKey(name: 'totalPages')
  int? totalPages;
  @JsonKey(name: 'pageData')
  List<PageData>? listData;

  SearchTinTucResponse(
    this.listData,
    this.pageIndex,
    this.totalItems,
    this.totalPages,
  );

  factory SearchTinTucResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTinTucResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTinTucResponseToJson(this);

  TinTucModel toDomain() => TinTucModel(
        pageIndex: pageIndex ?? 0,
        totalPages: totalPages ?? 0,
        totalItems: totalItems ?? 0,
        listData: listData?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class PageData {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'url')
  String? url;

  PageData({
    this.title,
    this.url,
  });

  factory PageData.fromJson(Map<String, dynamic> json) =>
      _$PageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataToJson(this);

  TinTucData toDomain() => TinTucData(
        title: title ?? '',
        url: url ?? '',
      );
}
