import 'dart:convert';

import 'package:ccvc_mobile/domain/model/widget_manage/widget_model.dart';
class DashBoardResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  DashBoardResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  DashBoardResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      final List<dynamic> result = const JsonDecoder().convert(json['data']);
      for (final v in result) {
        data!.add(Data.fromJson(v));
      }
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  String? id;
  String? name;
  String? widgetTypeId;
  String? description;
  String? code;

  String? component;
  bool? static;
  bool? isResizable;
  String? thumbnail;
  String? appId;
  int? order;
  bool? isShowing;
  Data({
    this.id,
    this.name,
    this.widgetTypeId,
    this.description,
    this.code,
    this.component,
    this.static,
    this.isResizable,
    this.thumbnail,
    this.appId,
    this.order,
    this.isShowing,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    widgetTypeId = json['widgetTypeId'];
    description = json['description'];
    code = json['code'];
    component = json['component'];
    static = json['static'];
    isResizable = json['isResizable'];
    thumbnail = json['thumbnail'];
    appId = json['appId'];
    order = json['order'];
    isShowing = json['isShowing'];
  }
  WidgetModel toDomain() =>
      WidgetModel(id: id ?? '', name: name ?? '', component: component ?? '');
}
