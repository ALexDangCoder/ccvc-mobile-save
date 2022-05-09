import 'dart:developer';

import 'package:ccvc_mobile/domain/model/home/pham_vi_model.dart';

class ListPhamViResponse {
  List<PhamViResponse>? data;
  int? statusCode;
  bool? succeeded;

  ListPhamViResponse({this.data, this.statusCode, this.succeeded});

  ListPhamViResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PhamViResponse>[];
      json['data'].forEach((v) {
        data!.add(PhamViResponse.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
  }
  List<PhamViModel> toDomain() {
    return data?.map((e) => e.toDomain()).toList() ?? [];
  }
}

class PhamViResponse {
  String? userId;
  String? canBoDepartmentId;
  String? userCanBoDepartmentId;
  String? chucVuId;
  String? donViId;
  String? chucVu;
  String? donVi;
  bool? isDefault;
  bool? isCurrentActive;

  PhamViResponse(
      {this.userId,
      this.canBoDepartmentId,
      this.userCanBoDepartmentId,
      this.chucVuId,
      this.donViId,
      this.chucVu,
      this.donVi,
      this.isDefault,
      this.isCurrentActive});

  PhamViModel toDomain() => PhamViModel(
        chucVu: chucVu ?? '',
        chucVuId: chucVuId ?? '',
        ngaySinh: DateTime.now().toString(),
        isCurrentActive: isCurrentActive ?? false,
        donVi: donVi ?? '',
      );

  PhamViResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    canBoDepartmentId = json['canBoDepartmentId'];
    userCanBoDepartmentId = json['userCanBoDepartmentId'];
    chucVuId = json['chucVuId'];
    donViId = json['donViId'];
    chucVu = json['chucVu'];
    donVi = json['donVi'];
    isDefault = json['isDefault'];
    isCurrentActive = json['isCurrentActive'];
  }
}
