import 'package:ccvc_mobile/tien_ich_module/domain/model/todo_dscv_model.dart';

class ToDoListDSCVResponse {
  List<DataDSCV>? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ToDoListDSCVResponse({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  ToDoListDSCVResponse.fromJson(Map<String, dynamic> json) {
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

  List<TodoDSCVModel> toModel() =>
      data?.map((e) => e.toDomain()).toList() ?? [];
}

class ToDoListUpdateResponseTwo {
  DataDSCV? data;
  int? statusCode;
  bool? succeeded;
  String? code;
  String? message;

  ToDoListUpdateResponseTwo({
    this.data,
    this.statusCode,
    this.succeeded,
    this.code,
    this.message,
  });

  ToDoListUpdateResponseTwo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = DataDSCV.fromJson(json['data']);
    }
    statusCode = json['statusCode'];
    succeeded = json['succeeded'];
    code = json['code'];
    message = json['message'];
  }
}

class DataDSCV {
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
  String? groupId;
  String? filePath;
  String? finishDay;

  DataDSCV({
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
    this.groupId,
    this.filePath,
    this.finishDay,
  });

  DataDSCV.fromJson(Map<String, dynamic> json) {
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
    groupId = json['groupId'];
    filePath = json['filePath'];
    finishDay = json['finishDay'];
  }

  TodoDSCVModel toDomain() => TodoDSCVModel(
        id: id,
        label: label,
        important: important ?? false,
        inUsed: inUsed,
        isDeleted: isDeleted,
        isTicked: isTicked,
        createdBy: createdBy,
        createdOn: createdOn,
        performer: performer,
        groupId: groupId,
        note: note,
        filePath: filePath,
        finishDay: finishDay,
      );
}
