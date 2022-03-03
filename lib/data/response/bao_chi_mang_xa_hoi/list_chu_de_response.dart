import 'dart:core';

import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/tat_ca_chu_de/list_chu_de.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_chu_de_response.g.dart';

@JsonSerializable()
class ListChuDeResponse {
  @JsonKey(name: 'pageData')
  List<ChuDeData>? listChuDe;

  ListChuDeResponse(this.listChuDe);

  factory ListChuDeResponse.fromJson(Map<String, dynamic> json) =>
      _$ListChuDeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListChuDeResponseToJson(this);

  ListChuDeModel toDomain() => ListChuDeModel(
        getlistChuDe: listChuDe?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class ChuDeData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'avartar')
  String? avartar;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'addressId')
  String? addressId;
  @JsonKey(name: 'publishedTime')
  String? publishedTime;

  ChuDeData({
    this.id,
    this.title,
    this.link,
    this.avartar,
    this.url,
    this.addressId,
    this.publishedTime,
  });

  factory ChuDeData.fromJson(Map<String, dynamic> json) =>
      _$ChuDeDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChuDeDataToJson(this);

  ChuDeModel toDomain() => ChuDeModel(
        id: id,
        title: title,
        link: link,
        avartar: avartar,
        url: url,
        addressId: addressId,
        publishedTime: publishedTime ?? '',
      );
}
