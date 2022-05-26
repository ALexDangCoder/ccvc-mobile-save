import '/home_module/domain/model/home/su_kien_model.dart';

class SuKienResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  SuKienResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  SuKienResponse.fromJson(Map<String, dynamic> json) {
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
  String? timeStart;

  Data({this.id, this.title, this.timeStart});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    timeStart = json['timeStart'];
  }

  SuKienModel toDomain() => SuKienModel(title: title ?? '', id: id ?? '');
}
