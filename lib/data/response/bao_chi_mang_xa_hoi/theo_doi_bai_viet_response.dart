import 'dart:core';

import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/theo_doi_bai_viet/theo_doi_bai_viet_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'theo_doi_bai_viet_response.g.dart';

@JsonSerializable()
class TheoDoiBaiVietResponse {
  @JsonKey(name: 'PageIndex')
  int? pageIndex;
  @JsonKey(name: 'TotalItems')
  int? totalItems;
  @JsonKey(name: 'TotalPages')
  int? totalPages;
  @JsonKey(name: 'PageData')
  List<BaiVietResponse>? listData;

  TheoDoiBaiVietResponse(
    this.listData,
    this.pageIndex,
    this.totalItems,
    this.totalPages,
  );

  factory TheoDoiBaiVietResponse.fromJson(Map<String, dynamic> json) =>
      _$TheoDoiBaiVietResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TheoDoiBaiVietResponseToJson(this);

  TheoDoiBaiVietModel toDomain() => TheoDoiBaiVietModel(
        pageIndex: pageIndex ?? 0,
        totalPages: totalPages ?? 0,
        totalItems: totalItems ?? 0,
        listBaiViet: listData?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class BaiVietResponse {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image_sources')
  List<String>? imageSources;
  @JsonKey(name: 'published_time')
  String? publishedTime;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'domain')
  String? domain;
  @JsonKey(name: 'icon_url')
  String? iconUrl;

  BaiVietResponse({
    this.title,
    this.imageSources,
    this.publishedTime,
    this.url,
    this.domain,
    this.iconUrl,
  });

  factory BaiVietResponse.fromJson(Map<String, dynamic> json) =>
      _$BaiVietResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaiVietResponseToJson(this);

  BaiVietModel toDomain() => BaiVietModel(
        title: title ?? '',
        imageSources: imageSources?.first ?? '',
        publishedTime: publishedTime ?? '',
        url: url ?? '',
        domain: domain ?? '',
        iconUrl: iconUrl ?? '',
      );
}
