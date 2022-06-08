import 'dart:core';

import 'package:ccvc_mobile/domain/model/bao_chi_mang_xa_hoi/menu_bcmxh.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_response.g.dart';

@JsonSerializable()
class MenuBCMXHResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'nodeid')
  int? nodeid;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'submenu')
  List<MenuData>? subMenu;

  MenuBCMXHResponse(this.id, this.title, this.subMenu);

  factory MenuBCMXHResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuBCMXHResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MenuBCMXHResponseToJson(this);

  ListMenuItemModel toDomain() => ListMenuItemModel(
        id: id ?? '',
        nodeid: nodeid ?? 0,
        title: title ?? '',
        subMenu: subMenu?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class MenuData {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'nodeid')
  int? nodeId;
  @JsonKey(name: 'title')
  String? title;

  MenuData({
    this.id,
    this.nodeId,
    this.title,
  });

  factory MenuData.fromJson(Map<String, dynamic> json) =>
      _$MenuDataFromJson(json);

  Map<String, dynamic> toJson() => _$MenuDataToJson(this);

  MenuItemModel toDomain() => MenuItemModel(
        id: id ?? '',
        nodeId: nodeId ?? 0,
        title: title ?? '',
      );
}
