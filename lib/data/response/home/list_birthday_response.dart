import 'package:ccvc_mobile/domain/model/home/birthday_model.dart';

class ListBirthDayResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ListBirthDayResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  ListBirthDayResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  int? pageIndex;
  int? totalPages;
  int? totalItems;
  List<PageData>? pageData;
  bool? hasPreviousPage;
  bool? hasNextPage;

  Data({this.pageIndex,
    this.totalPages,
    this.totalItems,
    this.pageData,
    this.hasPreviousPage,
    this.hasNextPage});

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    if (json['pageData'] != null) {
      pageData = <PageData>[];
      json['pageData'].forEach((v) {
        pageData!.add(PageData.fromJson(v));
      });
    }
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
  }
}

class PageData {
  String? tenNguoiGui;
  String? avatar;
  String? loiChuc;
  String? ngayGuiLoiChuc;

  PageData({this.tenNguoiGui, this.avatar, this.loiChuc, this.ngayGuiLoiChuc});

  PageData.fromJson(Map<String, dynamic> json) {
    tenNguoiGui = json['tenNguoiGui'];
    avatar = json['avatar'];
    loiChuc = json['loiChuc'];
    ngayGuiLoiChuc = json['ngayGuiLoiChuc'];
  }

  BirthdayModel toModel() =>
      BirthdayModel(
        tenNguoiGui: tenNguoiGui ?? '',
        avatar: avatar ?? '',
        loiChuc: loiChuc ?? '',
        ngayGuiLoiChuc: ngayGuiLoiChuc?.split('T')[0] ?? '',
      );
}
