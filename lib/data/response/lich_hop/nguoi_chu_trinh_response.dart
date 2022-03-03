import 'package:ccvc_mobile/domain/model/lich_hop/nguoi_chu_tri_model.dart';

class NguoiChuTriResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  NguoiChuTriResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  NguoiChuTriResponse.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? hoTen;
  String? donViId;
  String? userId;
  String? canBoId;
  String? tenDonVi;
  String? chucVuId;
  String? chucVu;
  String? userName;
  String? userTaoHoId;

  Items({
    this.id,
    this.hoTen,
    this.donViId,
    this.userId,
    this.canBoId,
    this.tenDonVi,
    this.chucVuId,
    this.chucVu,
    this.userName,
    this.userTaoHoId,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hoTen = json['hoTen'];
    donViId = json['donViId'];
    userId = json['userId'];
    canBoId = json['canBoId'];
    tenDonVi = json['tenDonVi'];
    chucVuId = json['chucVuId'];
    chucVu = json['chucVu'];
    userName = json['userName'];
    userTaoHoId = json['userTaoHoId'];
  }

  NguoiChutriModel toDomain() => NguoiChutriModel(
        id: id ?? '',
        hoTen: hoTen ?? '',
        userTaoHoId: userTaoHoId ?? '',
        userId: userId ?? '',
        tenDonVi: tenDonVi ?? '',
        donViId: donViId,
      );
}
