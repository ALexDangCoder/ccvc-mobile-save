import 'package:ccvc_mobile/domain/model/home/tinh_huong_khan_cap_model.dart';

class TinhHuongKhanCapResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  TinhHuongKhanCapResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  TinhHuongKhanCapResponse.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? linkOrContent;
  bool? isLink;

  Data({this.id, this.title, this.linkOrContent, this.isLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    linkOrContent = json['linkOrContent'];
    isLink = json['isLink'];
  }
  TinhHuongKhanCapModel toDomain() => TinhHuongKhanCapModel(
        id: id ?? '',
        isLink: isLink ?? false,
        title: title ?? '',
      );
}
