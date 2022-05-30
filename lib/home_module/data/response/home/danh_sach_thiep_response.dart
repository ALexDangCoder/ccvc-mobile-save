class DanhSachThiepResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  DanhSachThiepResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  DanhSachThiepResponse.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.pageIndex,
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
  String? id;
  String? tieuDe;
  String? imgUrl;
  int? order;
  String? type;
  bool? isDeleted;

  PageData(
      {this.id,
      this.tieuDe,
      this.imgUrl,
      this.order,
      this.type,
      this.isDeleted});

  PageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tieuDe = json['tieuDe'];
    imgUrl = json['imgUrl'];
    order = json['order'];
    type = json['type'];
    isDeleted = json['isDeleted'];
  }
}
