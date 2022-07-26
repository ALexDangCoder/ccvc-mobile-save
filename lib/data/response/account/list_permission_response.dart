import 'package:ccvc_mobile/domain/model/account/permission_app_model.dart';

class PermissionResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;

  PermissionResponse({
    this.data,
    this.statusCode,
    this.succeeded,
  });

  PermissionResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
  }
}

class Data {
  List<PermissionCellResponse>? qLVB;
  List<PermissionCellResponse>? pAKN;
  List<PermissionCellResponse>? vPDT;
  List<PermissionCellResponse>? qLNV;
  List<PermissionCellResponse>? hTCS;
  List<PermissionCellResponse>? hTKT;

  Data({
    this.qLVB,
    this.pAKN,
    this.vPDT,
    this.qLNV,
    this.hTCS,
    this.hTKT,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['QLVB'] != null) {
      qLVB = <PermissionCellResponse>[];
      json['QLVB'].forEach((v) {
        qLVB!.add(PermissionCellResponse.fromJson(v));
      });
    }
    if (json['PAKN'] != null) {
      pAKN = <PermissionCellResponse>[];
      json['PAKN'].forEach((v) {
        pAKN!.add(PermissionCellResponse.fromJson(v));
      });
    }
    if (json['VPDT'] != null) {
      vPDT = <PermissionCellResponse>[];
      json['VPDT'].forEach((v) {
        vPDT!.add(PermissionCellResponse.fromJson(v));
      });
    }
    if (json['QLNV'] != null) {
      qLNV = <PermissionCellResponse>[];
      json['QLNV'].forEach((v) {
        qLNV!.add(PermissionCellResponse.fromJson(v));
      });
    }
    if (json['HTCS'] != null) {
      hTCS = <PermissionCellResponse>[];
      json['HTCS'].forEach((v) {
        hTCS!.add(PermissionCellResponse.fromJson(v));
      });
    }
    if (json['HTKT'] != null) {
      hTKT = <PermissionCellResponse>[];
      json['HTKT'].forEach((v) {
        hTKT!.add(PermissionCellResponse.fromJson(v));
      });
    }
  }

  PermissionApp toDomain() => PermissionApp(
        qLVB: qLVB?.map((e) => e.toDomain()).toList() ?? [],
        pAKN: pAKN?.map((e) => e.toDomain()).toList() ?? [],
        vPDT: vPDT?.map((e) => e.toDomain()).toList() ?? [],
        qLNV: qLNV?.map((e) => e.toDomain()).toList() ?? [],
        hTKT: hTKT?.map((e) => e.toDomain()).toList() ?? [],
        hTCS: hTCS?.map((e) => e.toDomain()).toList() ?? [],
      );
}

class PermissionCellResponse {
  String? id;
  String? name;
  String? displayName;
  String? appId;
  String? appCode;

  PermissionCellResponse({
    this.id,
    this.name,
    this.displayName,
    this.appId,
    this.appCode,
  });

  PermissionCellResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    appId = json['appId'];
    appCode = json['appCode'];
  }

  PermissionModel toDomain() => PermissionModel(id: id ?? '', name: name ?? '');
}
