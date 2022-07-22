import 'package:ccvc_mobile/bao_cao_module/utils/extensions/string_extension.dart';
import 'package:ccvc_mobile/domain/model/tree_don_vi_model.dart';

class CanBoChiaSeResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;

  CanBoChiaSeResponse({this.data, this.statusCode, this.succeeded});

  CanBoChiaSeResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
  }

  List<Node<DonViModel>> toDomain() =>
      data?.items
          ?.map(
            (e) => Node<DonViModel>(e.toDomain()),
          )
          .toList() ??
      [];

  List<DonViModel> toDomainNhiemVu() =>
      data?.items
          ?.map(
            (e) => e.toDomain(),
          )
          .toList() ??
      [];
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
  String? userName;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? donVi;
  String? chucVu;
  List<String>? lstDonVi;
  List<String>? lstChucVu;
  bool? isSystemUser;
  bool? isDeleted;
  bool? isActivate;
  String? profileId;
  List<String>? donViIds;

  Items({
    this.id,
    this.userName,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.donVi,
    this.chucVu,
    this.lstDonVi,
    this.lstChucVu,
    this.isSystemUser,
    this.isDeleted,
    this.isActivate,
    this.profileId,
    this.donViIds,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];

    email = json['email'];

    phoneNumber = json['phoneNumber'];
    donVi = json['donVi'];
    chucVu = json['chucVu'];
    lstDonVi = json['lstDonVi'].cast<String>();
    lstChucVu = json['lstChucVu'].cast<String>();

    isSystemUser = json['isSystemUser'];
    isDeleted = json['isDeleted'];
    isActivate = json['isActivate'];
    profileId = json['profileId'];
    donViIds = json['donViIds'].cast<String>();
  }

  DonViModel toDomain() => DonViModel(
        id: id ?? '',
        chucVu: chucVu?.parseHtml() ?? '',
        tenCanBo: fullName ?? '',
        name: fullName ?? '',
      );
}
