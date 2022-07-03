import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';

class CountTodoResponse {
  List<CountTodoResponseData>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  CountTodoResponse(
      {this.data, this.statusCode, this.succeeded, this.code, this.message});

  CountTodoResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CountTodoResponseData>[];
      json['data'].forEach((v) {
        data!.add(CountTodoResponseData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }

  List<CountTodoModel> toModel() =>
      data?.map((e) => e.toDomain()).toList() ?? [];
}

class CountTodoResponseData {
  String? id;
  String? name;
  String? code;
  int? count;
  List<CountTodoResponseData>? childrenTodoViewModel;

  CountTodoResponseData({
    this.id,
    this.name,
    this.code,
    this.count,
    this.childrenTodoViewModel,
  });

  CountTodoResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    count = json['count'];
    if (json['childrenTodoViewModel'] != null) {
      childrenTodoViewModel = <CountTodoResponseData>[];
      json['childrenTodoViewModel'].forEach((v) {
        childrenTodoViewModel!.add(CountTodoResponseData.fromJson(v));
      });
    }
  }

  List<CountTodoModel> countTodoModel2() {
    final List<CountTodoModel> v2 = [];
    childrenTodoViewModel?.forEach((element) {
      v2.add(
        CountTodoModel(
          id: element.id,
          name: element.name,
          code: element.code,
          count: element.count,
        ),
      );
    });
    return v2;
  }

  CountTodoModel toDomain() {
    return CountTodoModel(
      id: id,
      name: name,
      code: code,
      count: count,
      childrenTodoViewModel: countTodoModel2(),
    );
  }
}
