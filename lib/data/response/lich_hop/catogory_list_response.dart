import 'package:ccvc_mobile/domain/model/lich_hop/loai_select_model.dart';

class CatogoryListResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  CatogoryListResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  CatogoryListResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  List<Items>? items;
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPage;

  Data({
    this.items,
    this.pageIndex,
    this.pageSize,
    this.totalCount,
    this.totalPage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPage = json['totalPage'];
  }
}

class Items {
  int? totalItems;
  String? id;
  String? name;
  int? order;
  int? type;

  Items({this.totalItems, this.id, this.name, this.order, this.type});

  Items.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    type = json['type'];
  }

  LoaiSelectModel toDomain() => LoaiSelectModel(
        totalItems: totalItems ?? 0,
        id: id ?? '',
        name: name ?? '',
        order: order ?? 0,
        type: type ?? 0,
      );
}
