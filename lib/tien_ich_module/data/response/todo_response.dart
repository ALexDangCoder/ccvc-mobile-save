import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';

import 'dscv_response.dart';

class ToDoListResponseTwo {
  List<DataDSCV>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ToDoListResponseTwo({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  ToDoListResponseTwo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataDSCV>[];
      json['data'].forEach((v) {
        data!.add(DataDSCV.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }

  TodoListModelTwo toDomain() {
    final List<DataDSCV> listImportant = data
            ?.where(
              (element) => element.isTicked == false && element.inUsed == true,
            )
            .toList() ??
        [];
    final List<DataDSCV> listTodoDone = data
            ?.where(
              (element) => element.isTicked == true && element.inUsed == true,
            )
            .toList() ??
        [];
    return TodoListModelTwo(
      listTodoDone: listTodoDone.map((e) => e.toDomain()).toList(),
      listTodoImportant: listImportant.map((e) => e.toDomain()).toList(),
    );
  }
}
