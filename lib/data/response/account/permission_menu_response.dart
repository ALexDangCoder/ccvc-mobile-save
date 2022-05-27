import 'package:ccvc_mobile/domain/model/account/permission_menu_model.dart';

class PermissionMenuResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  PermissionMenuResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  PermissionMenuResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
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
  String? code;
  String? routerName;
  String? url;
  int? sortOrder;

  String? icon;

  bool? isLinkPowerBi;

  bool? selected;

  Data({
    this.id,
    this.name,
    this.code,
    this.routerName,
    this.url,
    this.sortOrder,
    this.icon,
    this.isLinkPowerBi,
    this.selected,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    routerName = json['routerName'];
    url = json['url'];
    sortOrder = json['sortOrder'];

    icon = json['icon'];

    isLinkPowerBi = json['isLinkPowerBi'];

    selected = json['selected'];
  }

  PermissionMenuModel toDomain() =>
      PermissionMenuModel(code: code ?? '', id: id ?? '');
}
