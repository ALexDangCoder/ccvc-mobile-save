import '/home_module/domain/model/home/todo_model.dart';

class ToDoListResponse {
  List<Data>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ToDoListResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  ToDoListResponse.fromJson(Map<String, dynamic> json) {
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

  TodoListModel toDomain() {
    final List<Data> listImportant = data
            ?.where(
              (element) => element.isTicked == false && element.inUsed == true,
            )
            .toList() ??
        [];
    final List<Data> listTodoDone = data
            ?.where(
              (element) => element.isTicked == true && element.inUsed == true,
            )
            .toList() ??
        [];
    return TodoListModel(
      listTodoDone: listTodoDone.map((e) => e.toDomain()).toList(),
      listTodoImportant: listImportant.map((e) => e.toDomain()).toList(),
    );
  }
}

class ToDoListUpdateResponse {
  Data? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ToDoListUpdateResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  ToDoListUpdateResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class Data {
  String? id;
  String? label;
  bool? isTicked;
  bool? important;
  bool? inUsed;
  bool? isDeleted;
  String? createdOn;
  String? createdBy;
  String? updatedOn;
  String? updatedBy;

  String? note;

  String? performer;

  Data({
    this.id,
    this.label,
    this.isTicked,
    this.important,
    this.inUsed,
    this.isDeleted,
    this.createdOn,
    this.createdBy,
    this.updatedOn,
    this.updatedBy,
    this.note,
    this.performer,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    isTicked = json['isTicked'];
    important = json['important'];
    inUsed = json['inUsed'];
    isDeleted = json['isDeleted'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];
    updatedBy = json['updatedBy'];
    note = json['note'];
    performer = json['performer'];
  }

  TodoModel toDomain() => TodoModel(
        id: id,
        label: label,
        important: important ?? false,
        inUsed: inUsed,
        isDeleted: isDeleted,
        isTicked: isTicked,
        createdBy: createdBy,
        createdOn: createdOn,
      );
}
