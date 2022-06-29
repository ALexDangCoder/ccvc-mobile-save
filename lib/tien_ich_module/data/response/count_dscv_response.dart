import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';

class CountTodoResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  CountTodoResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  CountTodoResponse.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = statusCode;
    data['succeeded'] = succeeded;
    data['code'] = code;
    data['message'] = message;
    return data;
  }

  List<CountTodoModel> toModel() {
    return data?.map((e) => e.todoModel()).toList() ?? [];
  }
}

class Data {
  String? name;
  String? code;
  int? count;

  Data({this.name, this.code, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['count'] = count;
    return data;
  }

  CountTodoModel todoModel() => CountTodoModel(
        name: name,
        code: code,
        count: count,
      );
}
